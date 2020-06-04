defmodule Demo.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :subject_title, :string
      add :subject_category, :string
      add :produced_by, :binary_id
      add :production_date, :date
      add :finished_by, {:array, :binary_id}
      add :num_of_subscribers, :integer
      add :current_subscribers, {:array, :binary_id}
      add :past_subscribers, {:array, :binary_id}
      add :avg_completion_days, :decimal, precision: 8, scale: 2 #? days to complete the course

      timestamps()
    end

  end
end
