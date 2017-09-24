defmodule WorldCupDb.Entities.CountryParticipation do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Entities.CountryParticipation

  @primary_key false
  schema "country_participation" do
    field :cid, :integer, primary_key: true
    field :result, :integer
    field :year, :integer, primary_key: true
  end

  @doc false
  def changeset(%CountryParticipation{} = country_participation, attrs) do
    country_participation
    |> cast(attrs, [:cid, :year, :result])
    |> validate_required([:cid, :year, :result])
  end
end
