defmodule WorldCupDb.Web.QueryView do
  use WorldCupDb.Web, :view
  alias WorldCupDb.Web.QueryView

  def render("specific_cup.json", %{results: results}) do
    %{data: render_many(results, QueryView, "specific_cup.json")}
  end

  def render("specific_cup.json", %{query: query}) do
    {:ok, country} = Map.fetch(query, :country)
    {:ok, result} = Map.fetch(query, :result)
    %{country: country,
      result: result}
  end

  def render("specific_player.json", %{results: results}) do
    %{data: render_many(results, QueryView, "specific_player.json")}
  end

  def render("specific_player.json", %{query: query}) do
    {:ok, name} = Map.fetch(query, :name)
    {:ok, country} = Map.fetch(query, :country)
    {:ok, year} = Map.fetch(query, :year)
    {:ok, position} = Map.fetch(query, :position)
    {:ok, age} = Map.fetch(query, :age)
    {:ok, num_goals} = Map.fetch(query, :num_goals)
    %{name: name, country: country,
      year: year, position: position,
      age: age, num_goals: num_goals}
  end

  def render("superstars.json", %{results: results}) do
    %{data: render_many(results, QueryView, "superstars.json")}
  end

  def render("superstars.json", %{query: query}) do
    {:ok, name} = Map.fetch(query, :name)
    {:ok, year} = Map.fetch(query, :year)
    {:ok, country} = Map.fetch(query, :country)
    {:ok, num_goals} = Map.fetch(query, :num_goals)
    %{name: name,
      year: year,
      country: country,
      num_goals: num_goals}
  end

  def render("team_historical.json", %{results: results}) do
    %{data: render_many(results, QueryView, "team_historical.json")}
  end

  def render("team_historical.json", %{query: query}) do
    {:ok, country} = Map.fetch(query, :country)
    {:ok, num_cups} = Map.fetch(query, :num_cups)
    {:ok, total_wins} = Map.fetch(query, :total_wins)
    {:ok, total_ties} = Map.fetch(query, :total_ties)
    {:ok, total_losses} = Map.fetch(query, :total_losses)
    {:ok, total_goals} = Map.fetch(query, :total_goals)
    {:ok, total_points} = Map.fetch(query, :total_points)
    %{country: country, num_cups: num_cups,
      total_wins: total_wins, total_ties: total_ties,
      total_losses: total_losses, total_goals: total_goals,
      total_points: total_points}
  end

  def render("countrys_players.json", %{results: results}) do
    %{data: render_many(results, QueryView, "countrys_players.json")}
  end

  def render("countrys_players.json", %{query: query}) do
    {:ok, player} = Map.fetch(query, :player)
    {:ok, country} = Map.fetch(query, :country)
    {:ok, goals} = Map.fetch(query, :goals)
    {:ok, pks} = Map.fetch(query, :pks)
    %{player: player, country: country,
      goals: goals, pks: pks}
  end

  def render("crest_image.json", %{results: results}) do
    %{data: render_many(results, QueryView, "crest_image.json")}
  end

  def render("crest_image.json", %{query: query}) do
    {:ok, country} = Map.fetch(query, :country)
    {:ok, crestURL} = Map.fetch(query, :crestURL)
    %{country: country, crestURL: crestURL}
  end

  def render("goals_at_stadium.json", %{results: results}) do
    %{data: render_many(results, QueryView, "goals_at_stadium.json")}
  end

  def render("goals_at_stadium.json", %{query: query}) do
    {:ok, stadium} = Map.fetch(query, :stadium)
    {:ok, city} = Map.fetch(query, :city)
    {:ok, country} = Map.fetch(query, :country)
    {:ok, tot_goals} = Map.fetch(query, :tot_goals)
    {:ok, goals_per_game} = Map.fetch(query, :goals_per_game)
    %{stadium: stadium, city: city,
      country: country, tot_goals: tot_goals,
      goals_per_game: goals_per_game}
  end

  def render("most_wins.json", %{results: results}) do
    %{data: render_many(results, QueryView, "most_wins.json")}
  end

  def render("most_wins.json", %{query: query}) do
    {:ok, country} = Map.fetch(query, :country)
    {:ok, num_wins} = Map.fetch(query, :num_wins)
    %{country: country, num_wins: num_wins}
  end

  def render("country_rivalry.json", %{results: results}) do
    %{data: render_many(results, QueryView, "country_rivalry.json")}
  end

  def render("country_rivalry.json", %{query: query}) do
    {:ok, year} = Map.fetch(query, :year)
    {:ok, round} = Map.fetch(query, :round)
    {:ok, stadium} = Map.fetch(query, :stadium)
    {:ok, winner} = Map.fetch(query, :winner)
    {:ok, loser} = Map.fetch(query, :loser)
    {:ok, score} = Map.fetch(query, :score)
    {:ok, pk_score} = Map.fetch(query, :pk_score)
    %{year: year, round: round,
      stadium: stadium, winner: winner,
      loser: loser, score: score, pk_score: pk_score}
  end
end
