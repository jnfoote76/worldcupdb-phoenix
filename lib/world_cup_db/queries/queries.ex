defmodule WorldCupDb.Queries do
  import Ecto.Query

  require Ecto.DateTime
  require Logger

  use Timex

  alias WorldCupDb.Entities.Country
  alias WorldCupDb.Entities.CountryParticipation
  alias WorldCupDb.Entities.Game
  alias WorldCupDb.Entities.Player
  alias WorldCupDb.Entities.RosterSpot
  alias WorldCupDb.Entities.Stadium
  alias WorldCupDb.Entities.Cup


  ## New Queries

  # Player Participation Query
  def player_participation_query(filter_map) do
    filter = player_participation_filter(filter_map)

    from rs in RosterSpot,
    join: p in Player, on: rs.pid == p.id,
    join: c in Country, on: rs.cid == c.id,
    join: g in subquery(first_game()),
    on: rs.year == g.year,
    where: ^filter,
    select: %{name: p.name, country: c.name, year: rs.year,
              position: rs.position, first_game_date: g.date,
              birthdate: p.birthdate, num_goals: rs.goals},
    order_by: rs.year
  end

  def find_player_age(result) do
    {:ok, year} = Map.fetch(result, :year)
    {:ok, first_game_date} = Map.fetch(result, :first_game_date)
    {:ok, birthdate} = Map.fetch(result, :birthdate)
    age = player_age(year, first_game_date, birthdate)

    result
    |> Map.delete(:first_game_date)
    |> Map.delete(:birthdate)
    |> Map.put(:age, age)
  end

  defp player_age(year, first_game_date, player_birthdate) do
    {:ok, first_game_as_date} = Timex.parse("#{first_game_date} #{Integer.to_string(year)}",
                                            "{D} {Mfull} {YYYY}")
    {:ok, birthdate_as_date} = Timex.parse(player_birthdate, "{D} {Mfull} {YYYY}")
    Timex.diff(first_game_as_date, birthdate_as_date, :years)
  end

  defp player_participation_filter(filter_map) do
    dynamic = true

    dynamic = 
      if Map.has_key?(filter_map, :name) do
        name = Map.fetch!(filter_map, :name)
        dynamic([rs, p, c, g], p.name == ^name and ^dynamic)
      else
        dynamic
      end

    dynamic = 
      if Map.has_key?(filter_map, :country) do
        country = Map.fetch!(filter_map, :country)
        wildcard_country_str = "%" <> country <> "%"
        dynamic([rs, p, c, g], ilike(c.name, ^wildcard_country_str) and ^dynamic)
      else
        dynamic
      end

    dynamic = 
      if Map.has_key?(filter_map, :year) do
        year = Map.fetch!(filter_map, :year)
        dynamic([rs, p, c, g], rs.year == ^year and ^dynamic)
      else
        dynamic
      end

    dynamic
  end

  defp first_game do
    from g in Game,
    where: g.id == 1,
    select: %{year: g.year, date: g.date}
  end

  # Player Career Query
  def player_career_query(filter_map) do
    filter = player_career_filter(filter_map)

      from p in Player,
        join: pfc in subquery(player_first_country()), on: pfc.pid == p.id,
        join: pnc in subquery(player_num_cups()), on: pnc.pid == p.id,
        join: png in subquery(player_num_goals()), on: png.pid == p.id,
        join: c in Country, on: c.id == pfc.cid,
        where: ^filter,
        select: %{name: p.name, country: c.name, num_cups: pnc.num_cups, num_goals: png.num_goals}
  end

  def player_first_country do
    from rs in RosterSpot,
      select: %{pid: rs.pid, cid: rs.cid},
      distinct: rs.pid,
      order_by: rs.year
  end

  defp player_num_cups do
    from rs in RosterSpot,
      select: %{pid: rs.pid, num_cups: count(rs.year)},
      group_by: rs.pid
  end

  defp player_num_goals do
    from rs in RosterSpot,
      select: %{pid: rs.pid, num_goals: sum(rs.goals)},
      group_by: rs.pid
  end

  defp player_career_filter(filter_map) do
    filter = true

    filter = 
      if Map.has_key?(filter_map, :name) do
        name = Map.fetch!(filter_map, :name)
        dynamic([p, pfc, pnc, png, c], p.name == ^name and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :country) do
        country = Map.fetch!(filter_map, :country)
        wildcard_country_str = "%" <> country <> "%"
        dynamic([p, pfc, pnc, png, c], ilike(c.name, ^wildcard_country_str) and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :min_num_goals) do
        min_num_goals = Map.fetch!(filter_map, :min_num_goals)
        dynamic([p, pfc, pnc, png, c], png.num_goals >= ^min_num_goals and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :min_num_cups) do
        min_num_cups = Map.fetch!(filter_map, :min_num_cups)
        dynamic([p, pfc, pnc, png, c], pnc.num_cups >= ^min_num_cups and ^filter)
      else
        filter
      end

    filter
  end

  # Country Participation Query
  def country_participation_query(filter_map) do
    filter = country_participation_query_filter(filter_map)

    from cp in CountryParticipation,
      join: c in Country, on: c.id == cp.cid,
      select: %{year: cp.year, country: c.name, result: cp.result},
      where: ^filter,
      order_by: [cp.year, cp.result, c.name]
  end

  defp country_participation_query_filter(filter_map) do
    filter = true

    filter = 
      if Map.has_key?(filter_map, :year) do
        year = Map.fetch!(filter_map, :year)
        dynamic([cp, c], cp.year == ^year and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :country) do
        country = Map.fetch!(filter_map, :country)
        wildcard_country_str = "%" <> country <> "%"
        dynamic([cp, c], ilike(c.name, ^wildcard_country_str) and ^filter)
      else
        filter
      end

    filter
  end

  # Country Historical Query
  def country_historical_query(%{} = filter_map) do
    filter = country_historical_filter(filter_map)

    from c in Country,
      left_join: cnc in subquery(country_num_cups()), on: cnc.cid == c.id,
      left_join: cnw in subquery(country_num_wins()), on: cnw.cid == c.id,
      left_join: cnt in subquery(country_num_ties()), on: cnt.cid == c.id,
      left_join: cnl in subquery(country_num_losses()), on: cnl.cid == c.id,
      left_join: cnpkw in subquery(country_num_pk_wins()), on: cnpkw.cid == c.id,
      left_join: cnpkl in subquery(country_num_pk_losses()), on: cnpkl.cid == c.id,
      left_join: cwgs in subquery(country_win_goals_scored()), on: cwgs.cid == c.id,
      left_join: clgs in subquery(country_lose_goals_scored()), on: clgs.cid == c.id,
      left_join: cwga in subquery(country_win_goals_allowed()), on: cwga.cid == c.id,
      left_join: clga in subquery(country_lose_goals_allowed()), on: clga.cid == c.id,
      select: %{country: c.name, 
                num_cups: cnc.num_cups,
                total_wins: fragment("coalesce(?, 0)", cnw.total_wins), 
                total_ties: fragment("coalesce(?, 0)", cnt.total_ties),
                total_losses: fragment("coalesce(?, 0)", cnl.total_losses),
                total_pk_wins: fragment("coalesce(?, 0)", cnpkw.total_pk_wins),
                total_pk_losses: fragment("coalesce(?, 0)", cnpkl.total_pk_losses),
                total_goals_scored: fragment("? + ?", cwgs.total_win_goals_scored, clgs.total_lose_goals_scored),
                total_goals_allowed: fragment("? + ?", cwga.total_win_goals_allowed, clga.total_lose_goals_allowed),
                total_points: fragment("(3 * coalesce(?, 0)) + coalesce(?, 0) + (2 * coalesce(?, 0)) + coalesce(?, 0)", cnw.total_wins, cnt.total_ties, cnpkw.total_pk_wins, cnpkl.total_pk_losses)},
      where: ^filter,
      order_by: c.id
  end

  defp country_historical_filter(%{} = filter_map) do
    filter = true

    filter = 
      if Map.has_key?(filter_map, :country) do
        country = Map.fetch!(filter_map, :country)
        wildcard_country_str = "%" <> country <> "%"
        dynamic([c, cnc, cnw, cnt, cnl, cnpkw, cnpkl, cwgs, clgs, cwga, clga], ilike(c.name, ^wildcard_country_str) and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :min_num_cups) do
        min_num_cups = Map.fetch!(filter_map, :min_num_cups)
        dynamic([c, cnc, cnw, cnt, cnl, cnpkw, cnpkl, cwgs, clgs, cwga, clga], cnc.num_cups >= ^min_num_cups and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :min_num_wins) do
        min_num_wins = Map.fetch!(filter_map, :min_num_wins)
        dynamic([c, cnc, cnw, cnt, cnl, cnpkw, cnpkl, cwgs, clgs, cwga, clga], cnw.num_wins >= ^min_num_wins and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :min_num_goals) do
        min_num_goals = Map.fetch!(filter_map, :min_num_goals)
        dynamic([c, cnc, cnw, cnt, cnl, cnpkw, cnpkl, cwgs, clgs, cwga, clga], fragment("? + ? >= ?", cwgs.total_win_goals, clgs.total_lose_goals, ^min_num_goals) and ^filter)
      else
        filter
      end
      
    filter
  end

  def country_num_cups do
    from cp in CountryParticipation,
      select: %{cid: cp.cid, num_cups: count(cp.year)},
      group_by: cp.cid
  end

  def country_num_wins do
    from g in Game,
      select: %{cid: g.winnercid, total_wins: count(g.id)},
      where: (g.wgoals > g.lgoals and g.pkscore == ""),
      group_by: g.winnercid
  end

  def country_num_ties do
    from c in Country,
      left_join: g in Game, on: (g.winnercid == c.id or g.losercid == c.id),
      select: %{cid: c.id, total_ties: count(g.id)},
      where: (g.wgoals == g.lgoals and g.pkscore == ""),
      group_by: c.id
  end

  def country_num_losses do
    from g in Game,
      select: %{cid: g.losercid, total_losses: count(g.id)},
      where: (g.lgoals < g.wgoals and g.pkscore == ""),
      group_by: g.losercid
  end

  def country_num_pk_wins do
    from g in Game,
      select: %{cid: g.winnercid, total_pk_wins: count(g.id)},
      where: g.pkscore != "",
      group_by: g.winnercid
  end

  def country_num_pk_losses do
    from g in Game,
      select: %{cid: g.losercid, total_pk_losses: count(g.id)},
      where: g.pkscore != "",
      group_by: g.losercid
  end

  def country_win_goals_scored do
    from c in Country,
      left_join: g in Game, on: g.winnercid == c.id,
      select: %{cid: c.id, total_win_goals_scored: fragment("coalesce(sum(?), 0)", g.wgoals)},
      group_by: c.id
  end

  def country_lose_goals_scored do
    from c in Country,
      left_join: g in Game, on: g.losercid == c.id,
      select: %{cid: c.id, total_lose_goals_scored: fragment("coalesce(sum(?), 0)", g.lgoals)},
      group_by: c.id
  end

  def country_win_goals_allowed do
    from c in Country,
      left_join: g in Game, on: g.winnercid == c.id,
      select: %{cid: c.id, total_win_goals_allowed: fragment("coalesce(sum(?), 0)", g.lgoals)},
      group_by: c.id
  end

  def country_lose_goals_allowed do
    from c in Country,
      left_join: g in Game, on: g.losercid == c.id,
      select: %{cid: c.id, total_lose_goals_allowed: fragment("coalesce(sum(?), 0)", g.wgoals)},
      group_by: c.id
  end

  # Match Query
  def match_query(filter_map) do
    filter = match_query_filter(filter_map)

    from g in Game,
      join: c in Cup, on: c.year == g.year,
      join: h in Country, on: h.id == c.hostcid,
      join: s in Stadium, on: s.id == g.stadid,
      join: w in Country, on: w.id == g.winnercid,
      join: l in Country, on: l.id == g.losercid,
      select: %{year: g.year, date: g.date, time: g.time, stadium: s.name, city: s.city, host: h.name, round: g.round, 
                group: g.grid, winner: w.name, winner_goals: g.wgoals, loser: l.name, loser_goals: g.lgoals,
                pk_score: g.pkscore},
      where: ^filter,
      order_by: [g.year, g.id]
  end

  defp match_query_filter(filter_map) do
    filter = true

    filter = 
      if Map.has_key?(filter_map, :year) do
        year = Map.fetch!(filter_map, :year)
        dynamic([g, c, h, s, w, l], g.year == ^year and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :stadium) do
        stadium = Map.fetch!(filter_map, :stadium)
        dynamic([g, c, h, s, w, l], s.name == ^stadium and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :country_a) do
        country_a = Map.fetch!(filter_map, :country_a)
        wildcard_country_str = "%" <> country_a <> "%"
        dynamic([g, c, h, s, w, l], (ilike(w.name, ^wildcard_country_str) or ilike(l.name, ^wildcard_country_str)) and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :country_b) do
        country_b = Map.fetch!(filter_map, :country_b)
        wildcard_country_str = "%" <> country_b <> "%"
        dynamic([g, c, h, s, w, l], (ilike(w.name, ^wildcard_country_str) or ilike(l.name, ^wildcard_country_str)) and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :min_mov) do
        min_mov = Map.fetch!(filter_map, :min_mov)
        dynamic([g, c, h, s, w, l], fragment("? - ?", g.wgoals, g.lgoals) >= ^min_mov and ^filter)
      else
        filter
      end

    filter = 
      if Map.has_key?(filter_map, :went_to_pks) do
        went_to_pks = Map.fetch!(filter_map, :went_to_pks)

        if went_to_pks do
          dynamic([g, c, h, s, w, l], g.pkscore != "" and ^filter)
        else
          dynamic([g, c, h, s, w, l], g.pkscore == "" and ^filter)
        end
      else
        filter
      end

    filter
  end
end
