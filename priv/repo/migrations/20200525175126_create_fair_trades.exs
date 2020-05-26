defmodule Demo.Repo.Migrations.CreateFairTrades do
  use Ecto.Migration

  def change do
    create table(:fair_trades) do

      timestamps()
    end

  end
end
