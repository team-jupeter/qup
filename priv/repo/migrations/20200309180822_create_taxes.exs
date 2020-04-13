defmodule Demo.Repo.Migrations.CreateTaxes do
  use Ecto.Migration

  def change do
    create table(:taxes) do
      add :name, :string
      add :nationality, :string

      timestamps()
    end

  end
end
