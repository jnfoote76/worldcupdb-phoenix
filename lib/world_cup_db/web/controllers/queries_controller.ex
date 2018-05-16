defmodule WorldCupDb.Web.QueryController do
  use WorldCupDb.Web, :controller

  require Ecto.DateTime
  require Plug.Conn
  require Logger

  use Timex

  alias WorldCupDb.Repo
  alias WorldCupDb.Queries
  alias WorldCupDb.Queries.PlayerParticipationParams
  alias WorldCupDb.Queries.PlayerCareerParams
  alias WorldCupDb.Queries.CountryParticipationParams
  alias WorldCupDb.Queries.CountryHistoricalParams
  alias WorldCupDb.Queries.MatchParams

  action_fallback WorldCupDb.Web.FallbackController

  def player_participation(conn, _params) do
    case PlayerParticipationParams.changeset(%PlayerParticipationParams{}, conn.query_params) do
      %{:valid? => true, :changes => filter_map} ->
        query_results = 
          filter_map
          |> Queries.player_participation_query
          |> Repo.all
          |> Enum.map(&Queries.find_player_age/1)
        render(conn, "player_participation.json", results: query_results)

      changeset -> 
        conn
        |> put_status(400)
        |> render(WorldCupDb.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def player_career(conn, _params) do
    case PlayerCareerParams.changeset(%PlayerCareerParams{}, conn.query_params) do
      %{:valid? => true, :changes => filter_map} ->
        query_results = 
          filter_map
          |> Queries.player_career_query
          |> Repo.all
        render(conn, "player_career.json", results: query_results)

      changeset -> 
        conn
        |> put_status(400)
        |> render(WorldCupDb.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def country_participation(conn, _params) do
    case CountryParticipationParams.changeset(%CountryParticipationParams{}, conn.query_params) do
      %{:valid? => true, :changes => filter_map} ->
        query_results = 
          filter_map
          |> Queries.country_participation_query
          |> Repo.all
        render(conn, "country_participation.json", results: query_results)

      changeset -> 
        conn
        |> put_status(400)
        |> render(WorldCupDb.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def country_historical(conn, _params) do
    case CountryHistoricalParams.changeset(%CountryHistoricalParams{}, conn.query_params) do
      %{:valid? => true, :changes => filter_map} ->
        query_results = 
          filter_map
          |> Queries.country_historical_query
          |> Repo.all
        render(conn, "country_historical.json", results: query_results)

      changeset -> 
        conn
        |> put_status(400)
        |> render(WorldCupDb.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def match(conn, _params) do
    case MatchParams.changeset(%MatchParams{}, conn.query_params) do
      %{:valid? => true, :changes => filter_map} ->
        query_results = 
          filter_map
          |> Queries.match_query
          |> Repo.all
        render(conn, "match.json", results: query_results)

      changeset -> 
        conn
        |> put_status(400)
        |> render(WorldCupDb.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
