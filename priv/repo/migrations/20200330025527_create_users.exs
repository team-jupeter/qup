defmodule Demo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :name, :string
      add :nationality, :string
      add :username, :string
      add :ssn, :string
      add :email, :string
      add :birth_date, :naive_datetime
      add :password_hash, :string

      add :nation_signature, :text
      
      add :nation_id, references(:nations, type: :uuid, null: false)
      add :constitution_id, references(:constitutions, type: :uuid, null: false)
      
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :school_id, references(:schools, type: :uuid)

  
      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
