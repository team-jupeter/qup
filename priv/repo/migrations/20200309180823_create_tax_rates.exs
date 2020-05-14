defmodule Demo.Repo.Migrations.CreateTaxRates do
  use Ecto.Migration

  def change do
    create table(:tax_rates, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gpc_code, :string
      add :tax_percent, :decimal, precision: 5, scale: 2
      add :time_code, :string
      add :place_code, :string
      add :entity_code, :string

      add :taxation_id, references(:taxations, type: :uuid, null: false)

      timestamps()
    end

  end
end
