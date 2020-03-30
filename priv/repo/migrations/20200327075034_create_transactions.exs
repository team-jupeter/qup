defmodule Demo.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :buyer, :string
      add :seller, :string
      add :price, :string
      add :where, :string
      add :product, :string

      add :user_id, references(:users)

      timestamps()
    end
    create(unique_index(:transactions, :user_id))
  end
end
