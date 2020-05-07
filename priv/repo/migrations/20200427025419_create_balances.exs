defmodule Demo.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :balance, :integer

      timestamps()
    end

  end
end
