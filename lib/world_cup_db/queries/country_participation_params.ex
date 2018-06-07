defmodule WorldCupDb.Queries.CountryParticipationParams do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Queries.CountryParticipationParams
  
  schema "country_participation_params" do
    field :year, :integer
    field :country, :string
  end

  @doc false
  def changeset(%CountryParticipationParams{} = country_participation_params, attrs) do
    cast(country_participation_params, attrs, [:year, :country])
  end
end
  