defmodule Demo.Repo.Migrations.CreateCertificates do
  use Ecto.Migration

  def change do
    create table(:certificates, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :issued_by, :string
      add :issued_to, :string
      add :issued_date, :naive_datetime
      add :valid_until, :naive_datetime

      add :user_id, references(:users, type: :uuid, null: false)
      
      timestamps()
    end

  end
end
