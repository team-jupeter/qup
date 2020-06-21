defmodule Demo.Repo.Migrations.CreateGpcCodes do
  use Ecto.Migration

  def change do
    create table(:gpc_codes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :standard, :string
      add :code, :string
      add :name, :string

      timestamps()
    end

  end
end
