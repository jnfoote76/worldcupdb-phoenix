# WorldCupDb

This is a reimplementation of an old project I had for my databases class in college (but this time using Elixir and Phoenix!)

### Initial setup:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Optional (but recommended): Load my data into your database with `mix run priv/repo/seeds.exs`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

### Query reference
All queries can be run by sending a GET request to localhost:4000/api/query/<query_name>?<query_params>
For example, the specific cup query for 2014 can by run by hitting localhost:4000/api/query/specific_cup?year=2014

Queries:
* specific_cup
** Params: [year]
** Description: this query returns a JSON array representing the final standings for the cup of the given year and a JSON array representing each match played in the cup of the given year
* specific_player
** Params: [name]
