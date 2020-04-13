defmodule Demo.Repo.Migrations.CreatePhones do
  use Ecto.Migration

  def change do
    create table(:phones) do
      add :name, :string

      add :airport_id, references(:airports)

      timestamps()
    end

  end
end
