defmodule Demo.Repo.Migrations.CreateMentors do
  use Ecto.Migration

  def change do
    create table(:mentors, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :certificates, {:array, :string}

      add :user_id, references(:users, type: :uuid, null: false)

      timestamps()
    end

  end
end
