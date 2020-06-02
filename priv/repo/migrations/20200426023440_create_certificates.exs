defmodule Demo.Repo.Migrations.CreateCertificates do
  use Ecto.Migration

  def change do
    create table(:certificates, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :issued_by, :binary_id
      add :issued_to, :binary_id
      add :issued_date, :date
      add :valid_until, :date
      add :document, :binary_id

      add :user_id, references(:users, type: :uuid, null: false)
      
      timestamps()
    end

  end
end
