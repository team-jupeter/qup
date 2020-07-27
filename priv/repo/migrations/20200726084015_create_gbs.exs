defmodule Demo.Repo.Migrations.CreateGbs do
  use Ecto.Migration

  def change do
    create table(:gbs) do
      add :name, :string

      timestamps()
    end

  end
end
