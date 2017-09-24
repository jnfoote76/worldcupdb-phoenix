defmodule WorldCupDb.Entities.Player do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Entities.Player


  schema "player" do
    field :birthdate, :string
    field :name, :string
  end

  @doc false
  def changeset(%Player{} = player, attrs) do
    player
    |> cast(attrs, [:name, :birthdate])
    |> validate_required([:name, :birthdate])
  end
end
