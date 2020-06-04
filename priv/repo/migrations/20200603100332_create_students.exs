defmodule Demo.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students, primary_key: false) do 
      add :id, :uuid, primary_key: true
      add :name, :string 
      add :finished_courses, {:array, :string}
      add :current_courses, {:array, :string}
      add :past_schools, {:array, :string}
      add :desired_jobs, {:array, :string}
      add :recommended_jobs, {:array, :string}
    
      add(:scores, {:array, :jsonb}, default: [])
      add(:prizes, {:array, :jsonb}, default: [])
      add(:certificates, {:array, :jsonb}, default: [])
      add(:learning_path, :jsonb)

      add :user_id, references(:users, type: :uuid, null: false)
      add :school_id, references(:schools, type: :uuid, null: false)

      timestamps()
    end

  end
end
