defmodule WorldCupDb.Repo.Migrations.CreateWorldCupDb.Entities.Game do
  use Ecto.Migration

  def change do
    create table(:game, primary_key: false) do
      add :id, :integer, primary_key: true
      add :year, :integer, primary_key: true
      add :date, :string
      add :time, :string
      add :grid, :string
      add :round, :string
      add :stadid, :integer
      add :winnercid, :integer
      add :losercid, :integer
      add :wgoals, :integer
      add :lgoals, :integer
      add :pkscore, :string
    end

  end
end
