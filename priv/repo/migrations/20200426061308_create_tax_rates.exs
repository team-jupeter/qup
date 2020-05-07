defmodule Demo.Repo.Migrations.CreateTaxRates do
  use Ecto.Migration

  def change do
    create table(:tax_rates, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :gpc, :string
      add :time_code, :string
      add :place_code, :string
      add :entity_code, :string

      timestamps()
    end

  end
end
