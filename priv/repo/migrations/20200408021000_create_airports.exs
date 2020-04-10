defmodule Demo.Repo.Migrations.CreateAirports do
  use Ecto.Migration

  def change do
    create table(:airports) do
      add :name, :string
      add :tagline, :string

      # add :national_aiports_id, references(:national_airports)
    end
  end
end 
