defmodule Demo.Repo.Migrations.CreateMargets do
  use Ecto.Migration

  def change do
    create table(:margets) do

      timestamps()
    end

  end
end
