defmodule Demo.Repo.Migrations.CreateOrdinances do
  use Ecto.Migration

  def change do
    create table(:ordinances, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :previous_contents, :binary_id
      add :previous_hash, :string
      add :current_hash, :string
      add :article, :integer
      add :clause, :integer
      add :suggested_update, :string
      add :empowered_on, :naive_datetime

      timestamps()
    end

  end
end
