defmodule Demo.Repo.Migrations.CreateSchoolsMentors do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"

    create table(:schools_mentors, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v5(uuid_generate_v4(), '#{System.get_env("UUID_V5_SECRET")}')"), read_after_writes: true
      add :school_id, references(:schools, type: :uuid, null: false)
      add :mentor_id, references(:mentors, type: :uuid, null: false)

    end

    create(
      unique_index(:schools_mentors, [:school_id, :mentor_id], name: :school_id_mentor_id_unique_index)
    )
  end
end

