defmodule WorldCupDb.Repo.Migrations.CreateWorldCupDb.Entities.Stadium do
  use Ecto.Migration

  def change do
    create table(:stadium) do
      add :name, :string
      add :city, :string
      add :cid, :integer
    end

  end
end
