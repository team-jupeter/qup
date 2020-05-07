defmodule Demo.Repo.Migrations.CreatePortals do
  use Ecto.Migration

  def change do
    create table(:portals, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end

  end
end
