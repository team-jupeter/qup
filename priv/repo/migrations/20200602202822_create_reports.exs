defmodule Demo.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :previous_report, :binary_id
      add :current_hash, :string 
      add :title, :string
      add :written_by, :binary_id
      add :written_to, {:array, :binary_id}
      add :attached_documents, :text

      add :entity_id, references(:entities, type: :uuid, null: false)

      timestamps() 
    end

  end
end
