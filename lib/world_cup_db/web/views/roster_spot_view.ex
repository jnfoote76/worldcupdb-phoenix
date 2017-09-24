defmodule WorldCupDb.Web.RosterSpotView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.RosterSpotView

  def render("index.json", %{roster_spots: roster_spots}) do
    %{data: render_many(roster_spots, RosterSpotView, "roster_spot.json")}
  end

  def render("show.json", %{roster_spot: roster_spot}) do
    %{data: render_one(roster_spot, RosterSpotView, "roster_spot.json")}
  end

  def render("roster_spot.json", %{roster_spot: roster_spot}) do
    %{year: roster_spot.year,
      pid: roster_spot.pid,
      cid: roster_spot.cid,
      position: roster_spot.position,
      goals: roster_spot.goals,
      pkScores: roster_spot.pkscores}
  end
end
