defmodule WorldCupDb.Web.StadiumController do
  use WorldCupDb.Web, :controller

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.Stadium

  action_fallback WorldCupDb.Web.FallbackController

  def index(conn, _params) do
    stadiums = Entities.list_stadiums()
    render(conn, "index.json", stadiums: stadiums)
  end

  def create(conn, %{"stadium" => stadium_params}) do
    with {:ok, %Stadium{} = stadium} <- Entities.create_stadium(stadium_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", stadium_path(conn, :show, stadium))
      |> render("show.json", stadium: stadium)
    end
  end

  def show(conn, %{"id" => id}) do
    stadium = Entities.get_stadium!(id)
    render(conn, "show.json", stadium: stadium)
  end

  def update(conn, %{"id" => id, "stadium" => stadium_params}) do
    stadium = Entities.get_stadium!(id)

    with {:ok, %Stadium{} = stadium} <- Entities.update_stadium(stadium, stadium_params) do
      render(conn, "show.json", stadium: stadium)
    end
  end

  def delete(conn, %{"id" => id}) do
    stadium = Entities.get_stadium!(id)
    with {:ok, %Stadium{}} <- Entities.delete_stadium(stadium) do
      send_resp(conn, :no_content, "")
    end
  end
end
