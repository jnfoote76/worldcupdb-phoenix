defmodule WorldCupDb.Web.GameView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.GameView

  def render("index.json", %{games: games}) do
    %{data: render_many(games, GameView, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{id: game.id,
      year: game.year,
      date: game.date,
      time: game.time,
      grID: game.grid,
      round: game.round,
      stadID: game.stadid,
      winnerCID: game.winnercid,
      loserCID: game.losercid,
      wGoals: game.wgoals,
      lGoals: game.lgoals,
      pkScore: game.pkscore}
  end
end
