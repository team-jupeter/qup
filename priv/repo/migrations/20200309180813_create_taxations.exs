defmodule Demo.Repo.Migrations.CreateTaxations do
  use Ecto.Migration

  def change do
    create table(:taxations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :auth_code, :string
      add :unique_digits, :string
      add :tels, {:array, :string}
      add :t1_balance, :decimal, precision: 12, scale: 4, default: 0.0

      add :nation_id, references(:nations, type: :uuid, null: false)
      add :nation_supul_id, references(:nation_supuls, type: :uuid, null: false)
      timestamps()
    end

  end
end
