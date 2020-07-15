defmodule Demo.Repo.Migrations.CreateSils do
  use Ecto.Migration

  def change do
    create table(:sils, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :openhash_box, {:array, :string}
      add :current_hash, :string
      add :invoice_hash, :string
  
      add :entity_id, references(:entities, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end

  end
end
