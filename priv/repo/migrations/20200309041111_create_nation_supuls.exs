defmodule Demo.Repo.Migrations.CreateNationSupuls do
  use Ecto.Migration

  def change do
    create table(:nation_supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      add :global_supul_id, references(:global_supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
