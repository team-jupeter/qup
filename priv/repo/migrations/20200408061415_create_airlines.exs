defmodule Demo.Repo.Migrations.CreateAirlines do
  use Ecto.Migration

  def change do
    create table(:airlines) do
      add :name, :string
    end

    create unique_index(:airlines, [:name])
  end
end
