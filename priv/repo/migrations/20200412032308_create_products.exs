defmodule Demo.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :category, :string

      add :user_id, references(:users)
      add :trade_id, references(:trades)
      add :seller_id, references(:sellers)

      timestamps()
    end

  end
end
