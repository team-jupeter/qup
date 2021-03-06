defmodule Demo.Repo.Migrations.CreateNations do
  use Ecto.Migration

  def change do
    create table(:nations, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :nationality, :string
      add :name, :string
      add :constitution_signature, :string

      add :nation_supul_id, references(:nations, type: :uuid)
    end

    create unique_index(:nations, [:name])

  end
end
