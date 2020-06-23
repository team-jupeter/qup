defmodule Demo.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :name, :string
      add :type, :string
      add :owners, :string

      timestamps()
    end

  end
end
