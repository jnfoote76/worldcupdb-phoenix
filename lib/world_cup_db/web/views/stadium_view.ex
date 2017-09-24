defmodule WorldCupDb.Web.StadiumView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.StadiumView

  def render("index.json", %{stadiums: stadiums}) do
    %{data: render_many(stadiums, StadiumView, "stadium.json")}
  end

  def render("show.json", %{stadium: stadium}) do
    %{data: render_one(stadium, StadiumView, "stadium.json")}
  end

  def render("stadium.json", %{stadium: stadium}) do
    %{id: stadium.id,
      name: stadium.name,
      city: stadium.city,
      cid: stadium.cid}
  end
end
