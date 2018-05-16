defmodule WorldCupDb.Queries.PlayerParticipationParams do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Queries.PlayerParticipationParams
  
  schema "player_participation_params" do
    field :name, :string
    field :country, :string
    field :year, :integer
  end
  
  @doc false
  def changeset(%PlayerParticipationParams{} = player_participation_params, attrs) do
    player_participation_params
    |> cast(attrs, [:name, :country, :year])
  end
end
  