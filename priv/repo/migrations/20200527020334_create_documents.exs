defmodule Demo.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :presented_by, {:array, :binary_id}, default: []
      add :presented_to, :binary_id
      add :summary, :string
      add :attached_docs_list, {:array, :string}
      add :attached_docs_hashes, {:array, :string}
      add :hash_of_attached_docs_hashes, :string

      timestamps()
    end

  end
end
