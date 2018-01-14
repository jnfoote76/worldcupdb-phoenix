defmodule WorldCupDb.Entities.Stadium do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Entities.Stadium

  schema "stadium" do
    field :cid, :integer
    field :city, :string
    field :name, :string
  end

  @doc false
  def changeset(%Stadium{} = stadium, attrs) do
    stadium
    |> cast(attrs, [:name, :city, :cid])
    |> validate_required([:name, :city, :cid])
  end
end
