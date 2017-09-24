defmodule WorldCupDb.Web.PlayerController do
  use WorldCupDb.Web, :controller

  alias WorldCupDb.Entities
  alias WorldCupDb.Entities.Player

  action_fallback WorldCupDb.Web.FallbackController

  def index(conn, _params) do
    player = Entities.list_player()
    render(conn, "index.json", player: player)
  end

  def create(conn, %{"player" => player_params}) do
    with {:ok, %Player{} = player} <- Entities.create_player(player_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", player_path(conn, :show, player))
      |> render("show.json", player: player)
    end
  end

  def show(conn, %{"id" => id}) do
    player = Entities.get_player!(id)
    render(conn, "show.json", player: player)
  end

  def update(conn, %{"id" => id, "player" => player_params}) do
    player = Entities.get_player!(id)

    with {:ok, %Player{} = player} <- Entities.update_player(player, player_params) do
      render(conn, "show.json", player: player)
    end
  end

  def delete(conn, %{"id" => id}) do
    player = Entities.get_player!(id)
    with {:ok, %Player{}} <- Entities.delete_player(player) do
      send_resp(conn, :no_content, "")
    end
  end
end
