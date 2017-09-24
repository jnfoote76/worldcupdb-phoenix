defmodule WorldCupDb.Web.CupView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.CupView

  def render("index.json", %{cups: cups}) do
    %{data: render_many(cups, CupView, "cup.json")}
  end

  def render("show.json", %{cup: cup}) do
    %{data: render_one(cup, CupView, "cup.json")}
  end

  def render("cup.json", %{cup: cup}) do
    %{year: cup.year,
      hostCID: cup.hostcid,
      winnerCID: cup.winnercid}
  end
end
