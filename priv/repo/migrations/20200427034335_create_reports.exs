defmodule Demo.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do

      timestamps()
    end

  end
end
