defmodule WorldCupDb.Repo.Migrations.CreateWorldCupDb.Entities.CountryParticipation do
  use Ecto.Migration

  def change do
    create table(:country_participation, primary_key: false) do
      add :cid, :integer, primary_key: true
      add :year, :integer, primary_key: true
      add :result, :integer
    end

  end
end
