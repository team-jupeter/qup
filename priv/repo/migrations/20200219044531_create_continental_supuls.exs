defmodule Demo.Repo.Migrations.CreateContinentalSupuls do
  use Ecto.Migration

  def change do
    create table(:continental_supuls) do
      add :name, :string
      add :geographical_area, :string

      timestamps()
    end

  end
end
