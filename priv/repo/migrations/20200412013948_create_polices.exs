defmodule Demo.Repo.Migrations.CreatePolices do
  use Ecto.Migration

  def change do
    create table(:polices) do
      add :name, :string
      add :nationality, :string

      add :user_id, references(:users)

      timestamps()
    end

  end
end
