defmodule Demo.Repo.Migrations.CreateCertificates do
  use Ecto.Migration

  def change do
    create table(:certificates, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :issuer, :string
      add :valid_until, :string

      timestamps()
    end

  end
end
