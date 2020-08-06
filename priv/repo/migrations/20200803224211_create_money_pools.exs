defmodule Demo.Repo.Migrations.CreateFiatPools do
  use Ecto.Migration

  def change do
    create table(:fiat_pools, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :t1, :decimal, default: 0.0 #? fiat currency
      add :t2, :decimal, default: 0.0 #? GAB Stocks
      add :t3, :decimal, default: 0.0 #? Stock pools
      add :t4, :decimal, default: 0.0 #? Specific Securities
      add :reserve, :decimal, default: 0.0 #? 지불준비금

      add :gab_id, references(:gabs, type: :uuid)
  
      timestamps()
    end

  end
end
