defmodule Demo.Repo.Migrations.CreateTrades do
  use Ecto.Migration

  def change do
    create table(:trades) do
      add :price, :string
      add :password, :string

      # add :buyer_id, references(:users)
      # add :seller_id, references(:users)

      timestamps()
    end
    # create unique_index :trades, [:buyer_id, :seller_id]
  end
end
