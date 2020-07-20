defmodule Demo.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :title, :string

      add :family_id, references(:families, type: :uuid)
      
      timestamps()
    end

  end
end
