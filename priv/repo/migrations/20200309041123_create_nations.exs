defmodule Demo.Repo.Migrations.CreateNations do
  use Ecto.Migration

  def change do
    create table(:nations) do
      add :name, :string
    end

    create unique_index(:nations, [:name])

  end
end
