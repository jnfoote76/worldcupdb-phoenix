defmodule WorldCupDb.Web.QueryController do
  use WorldCupDb.Web, :controller

  require Ecto.DateTime
  require Plug.Conn
  require Logger

  use Timex

  alias WorldCupDb.Repo
  alias WorldCupDb.Queries

  action_fallback WorldCupDb.Web.FallbackController

  def specific_cup_standings(conn, _params) do
    {:ok, year} = Map.fetch(conn.query_params, "year")

    query_results = year
    |> String.to_integer
    |> Queries.specific_cup_query_standings
    |> Repo.all

    render(conn, "specific_cup_standings.json", results: query_results)
  end

  def specific_cup_games(conn, _params) do
    {:ok, year} = Map.fetch(conn.query_params, "year")

    query_results = year
    |> String.to_integer
    |> Queries.specific_cup_query_games
    |> Repo.all

    render(conn, "specific_cup_games.json", results: query_results)
  end

  def specific_player(conn, _params) do
    {:ok, name} = Map.fetch(conn.query_params, "name")

    query_results = name
    |> Queries.specific_player_query
    |> Repo.all
    |> Enum.map(&Queries.modified_player_result/1)

    render(conn, "specific_player.json", results: query_results)
  end

  def superstars(conn, _params) do
    query_results = Queries.superstars_query()
    |> Repo.all

    render(conn, "superstars.json", results: query_results)
  end

  def team_historical(conn, _params) do
    {:ok, name} = Map.fetch(conn.query_params, "name")

    results = name
    |> Queries.team_historical_query
    |> Repo.all
    |> Enum.map(&Queries.modified_team_historical_result/1)

    render(conn, "team_historical.json", results: results)
  end

  def countrys_players(conn, _params) do
    {:ok, name} = Map.fetch(conn.query_params, "name")

    results = name
    |> Queries.countrys_players_query
    |> Repo.all

    render(conn, "countrys_players.json", results: results)
  end

  def crest_image(conn, _params) do
    results = Queries.crest_image_query()
    |> Repo.all

    render(conn, "crest_image.json", results: results)
  end

  def goals_at_stadium(conn, _params) do
    results = Queries.goals_at_stadium_query()
    |> Repo.all

    render(conn, "goals_at_stadium.json", results: results)
  end

  def most_wins(conn, _params) do
    results = Queries.most_wins_query()
    |> Repo.all

    render(conn, "most_wins.json", results: results)
  end

  def country_rivalry(conn, _params) do
    {:ok, country_a} = Map.fetch(conn.query_params, "country_a")
    {:ok, country_b} = Map.fetch(conn.query_params, "country_b")

    results = country_a
    |> Queries.country_rivalry_query(country_b)
    |> Repo.all

    render(conn, "country_rivalry.json", results: results)
  end
end
