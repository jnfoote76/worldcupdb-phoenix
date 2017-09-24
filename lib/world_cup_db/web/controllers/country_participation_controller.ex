defmodule WorldCupDb.Web.CountryParticipationController do
  use WorldCupDb.Web, :controller

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.CountryParticipation

  action_fallback WorldCupDb.Web.FallbackController

  def index(conn, _params) do
    country_participations = Entities.list_country_participations()
    render(conn, "index.json", country_participations: country_participations)
  end

  def create(conn, %{"country_participation" => country_participation_params}) do
    with {:ok, %CountryParticipation{} = country_participation} <- Entities.create_country_participation(country_participation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", country_participation_path(conn, :show, country_participation))
      |> render("show.json", country_participation: country_participation)
    end
  end

  def show(conn, %{"id" => id}) do
    country_participation = Entities.get_country_participation!(id)
    render(conn, "show.json", country_participation: country_participation)
  end

  def update(conn, %{"id" => id, "country_participation" => country_participation_params}) do
    country_participation = Entities.get_country_participation!(id)

    with {:ok, %CountryParticipation{} = country_participation} <- Entities.update_country_participation(country_participation, country_participation_params) do
      render(conn, "show.json", country_participation: country_participation)
    end
  end

  def delete(conn, %{"id" => id}) do
    country_participation = Entities.get_country_participation!(id)
    with {:ok, %CountryParticipation{}} <- Entities.delete_country_participation(country_participation) do
      send_resp(conn, :no_content, "")
    end
  end
end
