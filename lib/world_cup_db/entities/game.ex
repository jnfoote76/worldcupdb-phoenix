defmodule WorldCupDb.Entities.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Entities.Game

  @primary_key false
  schema "game" do
    field :id, :integer
    field :date, :string
    field :grid, :string
    field :lgoals, :integer
    field :losercid, :integer
    field :pkscore, :string
    field :round, :string
    field :stadid, :integer
    field :time, :string
    field :wgoals, :integer
    field :winnercid, :integer
    field :year, :integer
  end

  @doc false
  def changeset(%Game{} = game, attrs) do
    game
    |> cast(attrs, [:year, :date, :time, :grid, :round, :stadid, :winnercid, :losercid, :wgoals, :lgoals, :pkscore])
    |> validate_required([:year, :date, :time, :grid, :round, :stadid, :winnercid, :losercid, :wgoals, :lgoals, :pkscore])
  end
end
