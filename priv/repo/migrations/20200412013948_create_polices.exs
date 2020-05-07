defmodule Demo.Repo.Migrations.CreatePolices do
  use Ecto.Migration

  def change do
    create table(:polices, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :nationality, :string

      add :user_id, references(:users, type: :uuid, null: false)

      timestamps()
    end

  end
end
