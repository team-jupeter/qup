defmodule Demo.Repo.Migrations.CreateStudentsCourses do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"

    create table(:students_courses, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v5(uuid_generate_v4(), '#{System.get_env("UUID_V5_SECRET")}')"), read_after_writes: true
      add :student_id, references(:students, type: :uuid, null: false)
      add :course_id, references(:courses, type: :uuid, null: false)

    end

    create(
      unique_index(:students_courses, [:student_id, :course_id], name: :student_id_course_id_unique_index)
    )
  end
end

