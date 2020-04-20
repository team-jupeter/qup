defmodule Demo.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :state, :string
      add :category, :string
      add :name, :string
      add :base_price, :integer
      add :discount, :integer
      add :ownership_history, :string
      add :remark, :string

      add :trade_id, references(:trades)
      add :user_id, references(:users)

      timestamps()
    end

  end
end
