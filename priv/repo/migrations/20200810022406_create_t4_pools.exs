defmodule Demo.Repo.Migrations.CreateT4Pools do
  use Ecto.Migration

  def change do
    create table(:t4_pools, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :denoting_currency, :string
      add :bse, :decimal, precision: 20, scale: 4, default: 0.0 
      add :db, :decimal, precision: 20, scale: 4, default: 0.0 
      add :ens, :decimal, precision: 20, scale: 4, default: 0.0 
      add :jpx, :decimal, precision: 20, scale: 4, default: 0.0 
      add :krx, :decimal, precision: 20, scale: 4, default: 0.0 
      add :lse, :decimal, precision: 20, scale: 4, default: 0.0 
      add :nasdaq, :decimal, precision: 20, scale: 4, default: 0.0 
      add :nse, :decimal, precision: 20, scale: 4, default: 0.0 
      add :nyse, :decimal, precision: 20, scale: 4, default: 0.0 
      add :sehk, :decimal, precision: 20, scale: 4, default: 0.0 
      add :six, :decimal, precision: 20, scale: 4, default: 0.0 
      add :sse, :decimal, precision: 20, scale: 4, default: 0.0 
      add :szse, :decimal, precision: 20, scale: 4, default: 0.0 
      add :tsx, :decimal, precision: 20, scale: 4, default: 0.0 

      add :gab_id, references(:gabs, type: :uuid)
      
      timestamps()
    end

  end
end
