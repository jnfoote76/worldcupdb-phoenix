defmodule WorldCupDb.Web.CountryController do
  use WorldCupDb.Web, :controller

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.Country

  action_fallback WorldCupDb.Web.FallbackController

  def index(conn, _params) do
    countries = Entities.list_countries()
    render(conn, "index.json", countries: countries)
  end

  def create(conn, %{"country" => country_params}) do
    with {:ok, %Country{} = country} <- Entities.create_country(country_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", country_path(conn, :show, country))
      |> render("show.json", country: country)
    end
  end

  def show(conn, %{"id" => id}) do
    country = Entities.get_country!(id)
    render(conn, "show.json", country: country)
  end

  def update(conn, %{"id" => id, "country" => country_params}) do
    country = Entities.get_country!(id)

    with {:ok, %Country{} = country} <- Entities.update_country(country, country_params) do
      render(conn, "show.json", country: country)
    end
  end

  def delete(conn, %{"id" => id}) do
    country = Entities.get_country!(id)
    with {:ok, %Country{}} <- Entities.delete_country(country) do
      send_resp(conn, :no_content, "")
    end
  end
end
