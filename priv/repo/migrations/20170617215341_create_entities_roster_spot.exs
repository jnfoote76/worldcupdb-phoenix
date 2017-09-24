defmodule WorldCupDb.Repo.Migrations.CreateWorldCupDb.Entities.RosterSpot do
  use Ecto.Migration

  def change do
    create table(:roster_spot, primary_key: false) do
      add :year, :integer, primary_key: true
      add :pid, :integer, primary_key: true
      add :cid, :integer
      add :position, :string
      add :goals, :integer
      add :pkscores, :integer
    end

  end
end
