defmodule Demo.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys) do

      timestamps()
    end

  end
end
