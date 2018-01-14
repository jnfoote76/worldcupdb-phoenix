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

  def specific_cup_query_standings(year) do
    from cp in CountryParticipation,
      join: c in Country, on: c.id == cp.cid,
      select: %{country: c.name, result: cp.result},
      where: cp.year == ^year,
      order_by: cp.result
  end

  def specific_cup_query_games(year) do
    from g in Game,
      join: w in Country, on: w.id == g.winnercid,
      join: l in Country, on: l.id == g.losercid,
      join: s in Stadium, on: s.id == g.stadid,
      select: %{game_num: g.id, round: g.round, date: g.date, time: g.time, group: g.grid, stadium: s.id, winner: w.name, loser: l.name, w_goals: g.wgoals, l_goals: g.lgoals, pk_score: g.pkscore},
      where: g.year == ^year,
      order_by: g.id
  end

  def specific_player_query(name) do
    from r in RosterSpot,
      join: p in Player, on: r.pid == p.id,
      join: c in Country, on: r.cid == c.id,
      join: g in subquery(first_game()),
      on: r.year == g.year,
      where: p.name == ^name,
      select: %{name: p.name, country: c.name, year: r.year,
                position: r.position, first_game_date: g.date,
                birthdate: p.birthdate, num_goals: r.goals},
      order_by: r.year
  end

  def modified_player_result(result) do
    {:ok, year} = Map.fetch(result, :year)
    {:ok, first_game_date} = Map.fetch(result, :first_game_date)
    {:ok, birthdate} = Map.fetch(result, :birthdate)
    age = player_age(year, first_game_date, birthdate)

    result
    |> Map.delete(:first_game_date)
    |> Map.delete(:player_birth)
    |> Map.put(:age, age)
  end

  defp player_age(year, first_game_date, player_birthdate) do
    {:ok, first_game_as_date} = Timex.parse("#{first_game_date} #{Integer.to_string(year)}",
                                            "{D} {Mfull} {YYYY}")
    {:ok, birthdate_as_date} = Timex.parse(player_birthdate, "{D} {Mfull} {YYYY}")
    Timex.diff(first_game_as_date, birthdate_as_date, :years)
  end

  defp first_game do
    from g in Game,
    where: g.id == 1,
    select: %{year: g.year, date: g.date}
  end

  def superstars_query do
    from rs in RosterSpot,
      join: p in Player, on: rs.pid == p.id,
      join: c in Country, on: rs.cid == c.id,
      join: pnc in subquery(player_num_cups()), on: pnc.pid == p.id,
      select: %{name: p.name, year: rs.year, country: c.name,
                num_goals: rs.goals},
      where: pnc.num_cups > 1,
      order_by: [p.name, rs.year]
  end

  defp player_num_cups do
    from rs in RosterSpot,
      select: %{pid: rs.pid, num_cups: count(rs.year)},
      group_by: rs.pid
  end

  def team_historical_query(name) do
    from c in Country,
      left_join: cnc in subquery(country_num_cups()), on: cnc.cid == c.id,
      left_join: cnw in subquery(country_num_wins()), on: cnw.cid == c.id,
      left_join: cnt in subquery(country_num_ties()), on: cnt.cid == c.id,
      left_join: cnl in subquery(country_num_losses()), on: cnl.cid == c.id,
      left_join: cwg in subquery(country_win_goals()), on: cwg.cid == c.id,
      left_join: clg in subquery(country_lose_goals()), on: clg.cid == c.id,
      select: %{country: c.name, num_cups: cnc.num_cups,
                total_wins: cnw.total_wins, total_ties: cnt.total_ties,
                total_losses: cnl.total_losses,
                total_win_goals: cwg.total_win_goals,
                total_lose_goals: clg.total_lose_goals},
      where: c.name == ^name,
      order_by: c.id
  end

  def modified_team_historical_result(result) do
    {:ok, total_wins} = Map.fetch(result, :total_wins)
    {:ok, total_ties} = Map.fetch(result, :total_ties)
    {:ok, total_win_goals} = Map.fetch(result, :total_win_goals)
    {:ok, total_lose_goals} = Map.fetch(result, :total_lose_goals)

    total_points = country_points(total_wins, total_ties)
    total_goals = country_total_goals(total_win_goals, total_lose_goals)

    result
    |> Map.delete(:country_win_goals)
    |> Map.delete(:country_lose_goals)
    |> Map.put(:total_points, total_points)
    |> Map.put(:total_goals, total_goals)
  end

  def country_num_cups do
    from cp in CountryParticipation,
      select: %{cid: cp.cid, num_cups: count(cp.year)},
      group_by: cp.cid
  end

  def country_num_wins do
    from g in Game,
      select: %{cid: g.winnercid, total_wins: count(g.id)},
      where: (g.wgoals > g.lgoals or g.pkscore != ""),
      group_by: g.winnercid
  end

  def country_num_ties do
    from c in Country,
      join: g in Game, on: (g.winnercid == c.id or g.losercid == c.id),
      select: %{cid: c.id, total_ties: count(g.id)},
      where: (g.wgoals == g.lgoals and g.pkscore == ""),
      group_by: c.id
  end

  def country_num_losses do
    from g in Game,
      select: %{cid: g.losercid, total_losses: count(g.id)},
      where: (g.lgoals < g.wgoals or g.pkscore != ""),
      group_by: g.losercid
  end

  def country_win_goals do
    from g in Game,
      join: c in Country, on: g.winnercid == c.id,
      select: %{cid: c.id, total_win_goals: sum(g.wgoals)},
      group_by: c.id
  end

  def country_lose_goals do
    from g in Game,
      join: c in Country, on: g.losercid == c.id,
      select: %{cid: c.id, total_lose_goals: sum(g.lgoals)},
      group_by: c.id
  end

  def country_points(wins, ties) do
    cond do
      wins != nil and ties != nil -> 3*wins + ties
      wins != nil -> 3*wins
      true -> ties
    end
  end

  def country_total_goals(win_goals, lose_goals) do
    cond do
      win_goals != nil and lose_goals != nil -> win_goals + lose_goals
      win_goals != nil -> win_goals
      true -> lose_goals
    end
  end

  def countrys_players_query(country) do
    from pgc in subquery(players_goal_count_gt0()),
    select: %{player: pgc.player, country: pgc.country, goals: pgc.goals,
              pks: pgc.pks},
    where: like(pgc.country, ^country),
    order_by: pgc.player
  end

  defp all_players_goal_count do
    from r in RosterSpot,
    group_by: [r.pid, r.cid],
    select: %{pid: r.pid, cid: r.cid, gls: sum(r.goals), pks: sum(r.pkscores)}
  end

  defp players_goal_count_gt0 do
    from apgc in subquery(all_players_goal_count()),
    join: p in Player, on: p.id == apgc.pid,
    join: c in Country, on: apgc.cid == c.id,
    select: %{player: p.name, country: c.name, goals: apgc.gls, pks: apgc.pks},
    where: apgc.gls > 0
  end

  def crest_image_query do
    from c in Country,
    select: %{country: c.name, crestURL: c.cresturl},
    order_by: c.name
  end

  def goals_at_stadium_query do
    from added in subquery(with_added_stadium_fields()),
    left_join: c in Country, on: c.id == added.cid,
    select: %{stadium: added.stadium, city: added.city,
              country: c.name, tot_goals: added.tot_goals,
              goals_per_game: added.goals_per_game},
    order_by: [desc: added.tot_goals]
  end

  defp goals_by_stad_id do
    from g in Game,
    select: %{stad_id: g.stadid,
              tot_goals: sum(fragment("? + ?", g.wgoals, g.lgoals)),
              tot_games: count(g.id)},
    group_by: g.stadid
  end

  defp with_added_stadium_fields do
    from by_stad_id in subquery(goals_by_stad_id()),
    right_join: s in Stadium, on: by_stad_id.stad_id == s.id,
    select: %{stadium: s.name, city: s.city, cid: s.cid,
              tot_goals: by_stad_id.tot_goals,
              goals_per_game: fragment("?::decimal / ?", by_stad_id.tot_goals,
                                      by_stad_id.tot_games)}
  end

  def most_wins_query do
    from by_cid in subquery(most_wins_by_cid()),
    join: c in Country, on: c.id == by_cid.cid,
    select: %{country: c.name, num_wins: by_cid.num_wins},
    order_by: [desc: by_cid.num_wins]
  end

  defp most_wins_by_cid do
    from cp in CountryParticipation,
    select: %{cid: cp.cid, num_wins: count(fragment("*"))},
    where: cp.result == 1,
    group_by: cp.cid
  end

  def country_rivalry_query(country_a, country_b) do
    from with_added in subquery(with_added_country_fields_winners()),
    left_join: c in Country, on: c.id == with_added.loser_cid,
    select: %{year: with_added.year, round: with_added.round,
              stadium: with_added.stadium, winner: with_added.winner,
              loser: c.name, score: with_added.score,
              pk_score: with_added.pk_score},
    where: ((ilike(with_added.winner, ^country_a) and ilike(c.name, ^country_b)) or
           (ilike(with_added.winner, ^country_b) and ilike(c.name, ^country_a))),
    order_by: with_added.year
  end

  def with_added_country_fields_winners do
    from by_cid in subquery(games_by_cid_winners()),
    left_join: c in Country, on: c.id == by_cid.winner_cid,
    select: %{year: by_cid.year, round: by_cid.round, stadium: by_cid.stadium,
              winner: c.name, loser_cid: by_cid.loser_cid, score: by_cid.score,
              pk_score: by_cid.pk_score}
  end

  def games_by_cid_winners do
    from g in Game,
    left_join: s in Stadium, on: s.id == g.stadid,
    select: %{year: g.year, round: g.round, stadium: s.name,
              winner_cid: g.winnercid, loser_cid: g.losercid,
              score: fragment("concat(concat(?, '-'), ?)", g.wgoals, g.lgoals),
              pk_score: g.pkscore}
  end
end
