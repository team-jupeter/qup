defmodule Demo.Repo.Migrations.CreateMoefs do
  use Ecto.Migration 

  def change do
    create table(:moefs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :settings, :map

      timestamps()
    end

  end
end
