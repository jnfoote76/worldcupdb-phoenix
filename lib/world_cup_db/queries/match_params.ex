defmodule WorldCupDb.Queries.MatchParams do
    use Ecto.Schema
    import Ecto.Changeset
    alias WorldCupDb.Queries.MatchParams
    
    schema "country_historical" do
      field :year, :string
      field :stadium, :string
      field :country_a, :string
      field :country_b, :string
      field :min_mov, :integer
      field :went_to_pks, :boolean
    end
  
    @doc false
    def changeset(%MatchParams{} = match_params, attrs) do
      cast(match_params, attrs, [:year, :stadium, :country_a, :country_b, :min_mov, :went_to_pks])
    end
end
    