defmodule WorldCupDb.Repo.Migrations.CreateWorldCupDb.Entities.Player do
  use Ecto.Migration

  def change do
    create table(:player) do
      add :name, :string
      add :birthdate, :string
    end

  end
end
