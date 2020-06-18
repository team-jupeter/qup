defmodule Demo.Repo.Migrations.CreateGlobalSupuls do
  use Ecto.Migration

  def change do
    create table(:global_supuls, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      add :global_signature, :string
      add :private_key, :string
      add :public_key, :string

      timestamps()
    end

  end
end
