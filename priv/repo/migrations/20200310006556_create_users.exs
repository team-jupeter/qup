defmodule Demo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :name, :string
      add :email, :string
      add :birth_date, :date
      add :password_hash, :string

      add :nation_id, references(:nations, type: :uuid, null: false)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
