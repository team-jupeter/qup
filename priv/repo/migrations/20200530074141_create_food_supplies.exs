defmodule Demo.Repo.Migrations.CreateFoodSupplies do
  use Ecto.Migration

  def change do
    create table(:food_supplies) do
      add :name, :string

      timestamps()
    end

  end
end
