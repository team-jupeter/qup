defmodule Demo.Repo.Migrations.CreateUserTransactions do
  use Ecto.Migration

  def change do
    create table(:user_transactions, primary_key: false) do
      add :transaction_id, references(:transactions, on_delete: :delete_all), primary_key: true
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      timestamps()
    end

    create(index(:user_transactions, [:transaction_id]))
    create(index(:user_transactions, [:user_id]))

    create(
      unique_index(:user_transactions, [:user_id, :transaction_id], name: :user_id_transaction_id_unique_index)
    )
  end
end 
