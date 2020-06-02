defmodule Demo.Repo.Migrations.CreateName do
  use Ecto.Migration

  def change do
    create table(:name) do
      add :purpose, :string
      add :address, :string

      timestamps()
    end

  end
end
