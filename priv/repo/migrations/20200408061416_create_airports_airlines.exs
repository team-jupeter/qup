defmodule Demo.Repo.Migrations.CreateAirportsAirlines do
  use Ecto.Migration

  def change do
    create table(:airports_airlines) do
      add :airport_id, references(:airports)
      add :airline_id, references(:airlines)

    end

    create unique_index(:airports_airlines, [:airport_id, :airline_id])
  end
end
 