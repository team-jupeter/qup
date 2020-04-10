defmodule Demo.Repo.Migrations.NationalAiports do
  use Ecto.Migration

  def change do
    create table(:national_airports) do
      add :name, :string

      add :airport_id, references(:airports)
      # add :nation_id, references(:nations)
    end

    create unique_index(:national_airports, [:airport_id])
  end
end
