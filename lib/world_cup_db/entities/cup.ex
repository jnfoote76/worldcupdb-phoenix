defmodule WorldCupDb.Entities.Cup do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Entities.Cup

  @primary_key {:year, :integer, []}
  schema "cup" do
    field :hostcid, :integer
    field :winnercid, :integer
  end

  @doc false
  def changeset(%Cup{} = cup, attrs) do
    cup
    |> cast(attrs, [:year, :hostcid, :winnercid])
    |> validate_required([:year, :hostcid, :winnercid])
  end
end
