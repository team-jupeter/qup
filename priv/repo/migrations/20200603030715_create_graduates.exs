defmodule Demo.Repo.Migrations.CreateGraduates do
  use Ecto.Migration

  def change do
    create table(:graduates) do

      timestamps()
    end

  end
end
