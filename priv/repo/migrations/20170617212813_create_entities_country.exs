defmodule WorldCupDb.Repo.Migrations.CreateWorldCupDb.Entities.Country do
  use Ecto.Migration

  def change do
    create table(:country) do
      add :name, :string
      add :cresturl, :string
    end

  end
end
