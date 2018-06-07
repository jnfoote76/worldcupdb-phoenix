defmodule WorldCupDb.Queries.CountryHistoricalParams do
    use Ecto.Schema
    import Ecto.Changeset
    alias WorldCupDb.Queries.CountryHistoricalParams
    
    schema "country_historical_params" do
      field :country, :string
      field :min_num_cups, :integer
      field :min_num_wins, :integer
      field :min_num_goals, :integer
    end
  
    @doc false
    def changeset(%CountryHistoricalParams{} = country_historical_params, attrs) do
      cast(country_historical_params, attrs, [:country, :min_num_cups, :min_num_wins, :min_num_goals])
    end
end
    