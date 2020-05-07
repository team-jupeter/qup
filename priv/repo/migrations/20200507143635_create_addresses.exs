defmodule Demo.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :city, :string
      add :street, :string
      add :state, :string
      add :nation, :string

      add :user_id, references(:users, type: :uuid, null: false)
      add :entity_id, references(:entities, type: :uuid, null: false)

      timestamps()
    end

  end
end
