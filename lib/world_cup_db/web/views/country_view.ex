defmodule WorldCupDb.Web.CountryView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.CountryView

  def render("index.json", %{countries: countries}) do
    %{data: render_many(countries, CountryView, "country.json")}
  end

  def render("show.json", %{country: country}) do
    %{data: render_one(country, CountryView, "country.json")}
  end

  def render("country.json", %{country: country}) do
    %{id: country.id,
      name: country.name,
      crestURL: country.cresturl}
  end
end
