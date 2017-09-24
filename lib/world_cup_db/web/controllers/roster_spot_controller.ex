defmodule WorldCupDb.Web.RosterSpotController do
  use WorldCupDb.Web, :controller

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.RosterSpot

  action_fallback WorldCupDb.Web.FallbackController

  def index(conn, _params) do
    roster_spots = Entities.list_roster_spots()
    render(conn, "index.json", roster_spots: roster_spots)
  end

  def create(conn, %{"roster_spot" => roster_spot_params}) do
    with {:ok, %RosterSpot{} = roster_spot} <- Entities.create_roster_spot(roster_spot_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", roster_spot_path(conn, :show, roster_spot))
      |> render("show.json", roster_spot: roster_spot)
    end
  end

  def show(conn, %{"id" => id}) do
    roster_spot = Entities.get_roster_spot!(id)
    render(conn, "show.json", roster_spot: roster_spot)
  end

  def update(conn, %{"id" => id, "roster_spot" => roster_spot_params}) do
    roster_spot = Entities.get_roster_spot!(id)

    with {:ok, %RosterSpot{} = roster_spot} <- Entities.update_roster_spot(roster_spot, roster_spot_params) do
      render(conn, "show.json", roster_spot: roster_spot)
    end
  end

  def delete(conn, %{"id" => id}) do
    roster_spot = Entities.get_roster_spot!(id)
    with {:ok, %RosterSpot{}} <- Entities.delete_roster_spot(roster_spot) do
      send_resp(conn, :no_content, "")
    end
  end
end
