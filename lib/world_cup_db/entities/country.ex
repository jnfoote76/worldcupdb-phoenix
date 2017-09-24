defmodule WorldCupDb.Entities.Country do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Entities.Country


  schema "country" do
    field :cresturl, :string
    field :name, :string
  end

  @doc false
  def changeset(%Country{} = country, attrs) do
    country
    |> cast(attrs, [:name, :cresturl, :string])
    |> validate_required([:name, :cresturl, :string])
  end
end
