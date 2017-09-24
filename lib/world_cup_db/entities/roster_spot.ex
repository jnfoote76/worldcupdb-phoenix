defmodule WorldCupDb.Entities.RosterSpot do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Entities.RosterSpot

  @primary_key false
  schema "roster_spot" do
    field :pid, :integer, primary_key: true
    field :year, :integer, primary_key: true
    field :cid, :integer
    field :goals, :integer
    field :pkscores, :integer
    field :position, :string
  end

  @doc false
  def changeset(%RosterSpot{} = roster_spot, attrs) do
    roster_spot
    |> cast(attrs, [:year, :pid, :cid, :position, :goals, :pkscores])
    |> validate_required([:year, :pid, :cid, :position, :goals, :pkscores])
  end
end
