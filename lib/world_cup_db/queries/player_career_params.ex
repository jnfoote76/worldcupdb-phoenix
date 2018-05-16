defmodule WorldCupDb.Queries.PlayerCareerParams do
  use Ecto.Schema
  import Ecto.Changeset
  alias WorldCupDb.Queries.PlayerCareerParams
  
  schema "player_career_params" do
    field :name, :integer
    field :country, :string
    field :min_num_goals, :integer
    field :min_num_cups, :integer
  end

  @doc false
  def changeset(%PlayerCareerParams{} = player_career_params, attrs) do
    cast(player_career_params, attrs, [:name, :country, :min_num_goals, :min_num_cups])
  end
end
  