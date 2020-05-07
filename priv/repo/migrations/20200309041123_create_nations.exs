defmodule Demo.Repo.Migrations.CreateNations do
  use Ecto.Migration

  def change do
    create table(:nations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
    end

    create unique_index(:nations, [:name])

  end
end
