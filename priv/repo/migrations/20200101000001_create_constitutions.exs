defmodule Demo.Repo.Migrations.CreateConstitutions do
  use Ecto.Migration

  def change do
    create table(:constitutions, primary_key: false) do
      add :id, :uuid, primary_key: true

      add :content, :text
      add :suggested_update, :string
      add :empowered_on, :naive_datetime
      add :signed_by, {:array, :string}, default: []

      add :nation_id, references(:nations, type: :uuid)
      
      timestamps()
    end

  end
end
