defmodule Demo.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :who, {:array, :binary_id}
      add :when, :string
      add :where, :string
      add :what, :string
      add :how, :string
      add :why, :string

      timestamps()
    end

  end
end
