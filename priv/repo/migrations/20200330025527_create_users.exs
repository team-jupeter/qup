defmodule Demo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :name, :string
      add :username, :string
      add :gps, {:array, :map}
      add :default_entity, :binary_id
      add :default_entity_name, :string
      add :nationality, :string
      add :auth_code, :string
      add :email, :string
      add :birth_date, :naive_datetime
      add :password_hash, :string
      add :supul_code, :string
      add :supul_name, :string

      
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :nation_id, references(:nations, type: :uuid, null: false)
      add :constitution_id, references(:constitutions, type: :uuid, null: false)
      
      add :entity_id, references(:entities, type: :uuid, null: false)
      add :school_id, references(:schools, type: :uuid)

  
      timestamps()
    end

    create(unique_index(:users, [:email, :username]))
  end
end
