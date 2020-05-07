defmodule Demo.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams, primary_key: false) do
      add :id, :uuid, primary_key: true
      add(:name, :string)
      add(:year_started, :integer)
      add(:year_ended, :integer)

      add(:members, {:array, :jsonb}, default: [])
      add(:projects, {:array, :jsonb}, default: [])

      add(:entity_id, references(:entities, type: :uuid, null: false))

      timestamps()
    end
  end
end
