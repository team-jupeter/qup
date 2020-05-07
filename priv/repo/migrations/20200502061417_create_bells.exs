defmodule Demo.Repo.Migrations.CreateBells do
  use Ecto.Migration

  def change do
    create table(:bells, primary_key: false) do
      add :who, :string
      add :when, :string
      add :where, :string
      add :what, :string
      add :why, :string

      timestamps()
    end

  end
end
