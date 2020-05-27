defmodule Demo.Repo.Migrations.CreateDocuments do
  use Ecto.Migration

  def change do
    create table(:documents, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :titile, :string
      add :summary, :string
      add :table_of_content, {:array, :string}
      add :content, :string

      timestamps()
    end

  end
end
