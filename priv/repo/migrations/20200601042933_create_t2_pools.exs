defmodule Demo.Repo.Migrations.CreatePools do
  use Ecto.Migration

  def change do
    create table(:t2_pools, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :pool_amount, :decimal, precision: 15, scale: 2 #? the  amount of the pool
      add :to_buy, {:array, :map}, default: [] #? select some stocks in Korean stock market to buy
      add :to_sell, {:array, :map}, default: [] #? select some stocks to sell in the Korean T2 Pool
      add :t2_index, :decimal, precision: 7, scale: 2 #? divide the sum of all the stock prices in the pool by the number of companies in the pool.
  
      add :nation_id, references(:nations, type: :uuid, null: false)

      timestamps()
    end

  end
end
