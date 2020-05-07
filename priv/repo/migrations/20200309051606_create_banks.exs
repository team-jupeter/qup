defmodule Demo.Repo.Migrations.CreateBanks do
  use Ecto.Migration

  def change do
    create table(:banks, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :nationality, :string

      add :nation_id, references(:nations, type: :uuid, null: false)

      timestamps()
    end

  end
end
