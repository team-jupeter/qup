defmodule Demo.Repo.Migrations.CreateTraffics do
  use Ecto.Migration

  def change do
    create table(:traffics) do
      add :car_amount, :string
      add :airline_amount, :string
      add :ship_amount, :string
      add :land_routes, :string
      add :water_routes, :string
      add :air_routes, :string

      timestamps()
    end

  end
end
