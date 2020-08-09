defmodule Demo.Repo.Migrations.CreateMoneyPools do
  use Ecto.Migration

  def change do
    create table(:money_pools, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :t1, :decimal, precision: 12, scale: 4, default: 0.0 #? fiat currency
      add :t2, :decimal, precision: 12, scale: 4, default: 0.0 #? GAB Stocks
      add :t3, :decimal, precision: 12, scale: 4, default: 0.0 #? Stock pools
      add :t4, :decimal, precision: 12, scale: 4, default: 0.0 #? Specific Securities
      add :reserve, :decimal, precision: 12, scale: 4, default: 0.0 #? 지불준비금

      add :gab_id, references(:gabs, type: :uuid)
  
      timestamps()
    end

  end
end
