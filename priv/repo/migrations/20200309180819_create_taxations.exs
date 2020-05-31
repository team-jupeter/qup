defmodule Demo.Repo.Migrations.CreateTaxations do
  use Ecto.Migration

  def change do
    create table(:taxations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      add :nation_id, references(:nations, type: :uuid, null: false)
      timestamps()
    end

  end
end
