defmodule Demo.Repo.Migrations.CreateCdcs do
  use Ecto.Migration

  def change do
    create table(:cdcs, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :nation_id, references(:nations, type: :uuid, null: false)
      
      timestamps()
    end

  end
end
