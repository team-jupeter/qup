defmodule Demo.Repo.Migrations.CreateT2Items do
  use Ecto.Migration

  def change do
    create table(:t2_items, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :stock_price, :decimal, precision: 10, scale: 2 #? market price of the share which this item represents.
      add :amount, :decimal, precision: 15, scale: 2 #? T1 amount this security in the pool
      add :proportion_in_pool, :decimal, precision: 5, scale: 2 #? proportion in the pool
      add :proportion_in_market,:decimal, precision: 5, scale: 2 #? market capitalization ratio in Korean security market.
      add :intrinsic_price_gab, :decimal, precision: 7, scale: 2 #? difference between market price and re_fmv.
  
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :t2_list_id, references(:t2_lists, type: :uuid, null: false)

      timestamps()
    end

  end
end
