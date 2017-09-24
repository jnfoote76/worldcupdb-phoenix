defmodule WorldCupDb.Web.CountryParticipationView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.CountryParticipationView

  def render("index.json", %{country_participations: country_participations}) do
    %{data: render_many(country_participations, CountryParticipationView, "country_participation.json")}
  end

  def render("show.json", %{country_participation: country_participation}) do
    %{data: render_one(country_participation, CountryParticipationView, "country_participation.json")}
  end

  def render("country_participation.json", %{country_participation: country_participation}) do
    %{cid: country_participation.cid,
      year: country_participation.year,
      result: country_participation.result}
  end
end
