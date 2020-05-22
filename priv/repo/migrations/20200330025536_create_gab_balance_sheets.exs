defmodule Demo.Repo.Migrations.CreateGabBalanceSheets do
  use Ecto.Migration

  def change do
    create table(:gab_balance_sheets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :monetary_unit, :string
      add :t1, :decimal, precision: 12, scale: 2, default: 0.0
      add :t2, :decimal, precision: 12, scale: 2, default: 0.0
      add :t3, :decimal, precision: 12, scale: 2, default: 0.0
      
      add :cash, :decimal, precision: 12, scale: 2, default: 0.0
      

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)

      timestamps()
    end

  end
end
