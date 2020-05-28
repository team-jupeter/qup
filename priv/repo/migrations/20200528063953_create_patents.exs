defmodule Demo.Repo.Migrations.CreatePatents do
  use Ecto.Migration

  def change do
    create table(:patents, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end

  end
end
