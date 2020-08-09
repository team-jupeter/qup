defmodule Demo.Repo.Migrations.CreateT4s do
  use Ecto.Migration

  def change do
    create table(:t4s, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :bse, :decimal, precision: 12, scale: 4, default: 0.0 
      add :db, :decimal, precision: 12, scale: 4, default: 0.0 
      add :ens, :decimal, precision: 12, scale: 4, default: 0.0 
      add :jpx, :decimal, precision: 12, scale: 4, default: 0.0 
      add :krx, :decimal, precision: 12, scale: 4, default: 0.0 
      add :lse, :decimal, precision: 12, scale: 4, default: 0.0 
      add :nasdaq, :decimal, precision: 12, scale: 4, default: 0.0 
      add :nse, :decimal, precision: 12, scale: 4, default: 0.0 
      add :nyse, :decimal, precision: 12, scale: 4, default: 0.0 
      add :sehk, :decimal, precision: 12, scale: 4, default: 0.0 
      add :six, :decimal, precision: 12, scale: 4, default: 0.0 
      add :sse, :decimal, precision: 12, scale: 4, default: 0.0 
      add :szse, :decimal, precision: 12, scale: 4, default: 0.0 
      add :tsx, :decimal, precision: 12, scale: 4, default: 0.0 

      add(:entity_id, references(:entities, type: :uuid))
      add(:balance_sheet_id, references(:balance_sheets, type: :uuid))
      
      timestamps()
    end

  end
end
