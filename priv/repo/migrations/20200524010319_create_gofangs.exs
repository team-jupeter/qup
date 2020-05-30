defmodule Demo.Repo.Migrations.Creategopangs do
  use Ecto.Migration

  def change do
    create table(:gopangs, primary_key: false) do
      add :name, :string
  
      add :supul_id, references(:supuls, type: :uuid, null: false, on_delete: :nothing)

      timestamps()
    end
 
  end
end
