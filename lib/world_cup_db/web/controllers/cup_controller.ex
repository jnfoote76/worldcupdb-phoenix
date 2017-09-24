defmodule WorldCupDb.Web.CupController do
  use WorldCupDb.Web, :controller

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.Cup

  action_fallback WorldCupDb.Web.FallbackController

  def index(conn, _params) do
    cups = Entities.list_cups()
    render(conn, "index.json", cups: cups)
  end

  def create(conn, %{"cup" => cup_params}) do
    with {:ok, %Cup{} = cup} <- Entities.create_cup(cup_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", cup_path(conn, :show, cup))
      |> render("show.json", cup: cup)
    end
  end

  def show(conn, %{"id" => id}) do
    cup = Entities.get_cup!(id)
    render(conn, "show.json", cup: cup)
  end

  def update(conn, %{"id" => id, "cup" => cup_params}) do
    cup = Entities.get_cup!(id)

    with {:ok, %Cup{} = cup} <- Entities.update_cup(cup, cup_params) do
      render(conn, "show.json", cup: cup)
    end
  end

  def delete(conn, %{"id" => id}) do
    cup = Entities.get_cup!(id)
    with {:ok, %Cup{}} <- Entities.delete_cup(cup) do
      send_resp(conn, :no_content, "")
    end
  end
end
