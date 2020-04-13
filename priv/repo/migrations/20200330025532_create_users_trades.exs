defmodule Demo.Repo.Migrations.CreateUsersTrades do
  use Ecto.Migration

  def change do
    create table(:user_trades, primary_key: false) do
      add :trade_id, references(:trades, on_delete: :delete_all), primary_key: true
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true
      timestamps()
    end

    # create(index(:user_trades, [:trade_id]))
    # create(index(:user_trades, [:user_id]))

    create(
      unique_index(:user_trades, [:user_id, :trade_id], name: :user_id_trade_id_unique_index)
    )
  end
end
