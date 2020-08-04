defmodule Demo.Repo.Migrations.CreateGabs do
  use Ecto.Migration

  def change do
    create table(:gabs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :gab_balance, :decimal, default: 0.0
      add :unique_digits, :string
      add :tels, {:array, :string}

      add :nation_id, references(:nations, type: :uuid)

      timestamps()
    end

  end
end
