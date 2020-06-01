defmodule Demo.Repo.Migrations.CreateGovBalanceSheets do
  use Ecto.Migration

  def change do
    create table(:gov_balance_sheets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :monetary_unit, :string

      add :t1, :decimal, precision: 15, scale: 2
      add :t2, :decimal, precision: 15, scale: 2
      add :t3, :decimal, precision: 15, scale: 2

      add :cashes, {:array, :map} 
      
      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)

      timestamps()
    end

  end
end
