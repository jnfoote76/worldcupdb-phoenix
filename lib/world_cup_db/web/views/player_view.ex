defmodule WorldCupDb.Web.PlayerView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.PlayerView

  def render("index.json", %{player: player}) do
    %{data: render_many(player, PlayerView, "player.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, PlayerView, "player.json")}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      name: player.name,
      birthdate: player.birthdate}
  end
end
