defmodule WorldCupDb.Repo.Migrations.CreateWorldCupDb.Entities.Cup do
  use Ecto.Migration

  def change do
    create table(:cup, primary_key: false) do
      add :year, :integer, primary_key: true
      add :hostcid, :integer
      add :winnercid, :integer
    end

  end
end
