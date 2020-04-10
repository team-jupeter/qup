defmodule Demo.Repo.Migrations.CreatePassenger do
  use Ecto.Migration

  def change do
    create table(:passengers) do

      add :name, :string
      add :email, :string

      add :airline, :string
      add :departure_airport, :string
      add :arrival_airport, :string
      add :boarding_time, :string
      add :boarding_gate, :string
      add :boarding_door, :string

      add :scanned_fingerprint, :string
      add :scanned_face, :string
      add :scanned_weight, :string
      add :scanned_height, :string
      # add :interpol_test, :string


      add :check_fingerprint, :boolean, default: false
      add :check_face, :boolean, default: false
      add :check_weight, :boolean, default: false
      add :check_height, :boolean, default: false
      # add :check_interpol, :boolean, default: false

      # add :user_id, references(:users)
      add :airport_id, references(:airports)

      timestamps()
    end
  end
  # create unique_index(:passengers, [:user_id]) # passenger to user is one to one

end
