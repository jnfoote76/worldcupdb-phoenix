defmodule WorldCupDb.Web.QueryView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.QueryView

  def render("player_participation.json", %{results: results}) do
    %{data: render_many(results, QueryView, "player_participation.json")}
  end

  def render("player_participation.json", %{query: query}) do
    query
  end

  def render("player_career.json", %{results: results}) do
    %{data: render_many(results, QueryView, "player_career.json")}
  end
  
  def render("player_career.json", %{query: query}) do
    query
  end

  def render("country_participation.json", %{results: results}) do
    %{data: render_many(results, QueryView, "country_participation.json")}
  end
  
  def render("country_participation.json", %{query: query}) do
    query
  end

  def render("country_historical.json", %{results: results}) do
    %{data: render_many(results, QueryView, "country_historical.json")}
  end
  
  def render("country_historical.json", %{query: query}) do
    query
  end

  def render("match.json", %{results: results}) do
    %{data: render_many(results, QueryView, "match.json")}
  end
  
  def render("match.json", %{query: query}) do
    query
  end
end
