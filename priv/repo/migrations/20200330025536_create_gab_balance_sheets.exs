defmodule Demo.Repo.Migrations.CreateGabBalanceSheets do
  use Ecto.Migration

  def change do
    create table(:gab_balance_sheets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :monetary_unit, :string
      add :t1s, {:array, :map}
      add :t2s, {:array, :map} 
      add :t3s, {:array, :map} 

      add :cashes, {:array, :map} 
      

      add :financial_report_id, references(:financial_reports, type: :uuid, null: false)

      timestamps()
    end

  end
end
