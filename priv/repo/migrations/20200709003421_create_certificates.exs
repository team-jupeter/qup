defmodule Demo.Repo.Migrations.CreateCertificates do
  use Ecto.Migration

  def change do
    create table(:certificates) do
      add :name, :string
      add :issued_by, :string
      add :issued_on, :string
      add :valid_until, :string
      add :auth_code, :string
      add :granted_to, :string
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:certificates, [:user_id])
  end
end
