defmodule Demo.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add(:name, :string)
      add(:year_started, :integer)
      add(:year_ended, :integer)

      add(:company_id, references(:companies))

      timestamps()
    end
  end
end
