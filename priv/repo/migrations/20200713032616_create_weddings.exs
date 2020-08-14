defmodule Demo.Repo.Migrations.CreateWeddings do
  use Ecto.Migration

  def change do
    create table(:weddings, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :input_id, :binary_id
      add :input_name, :string
      add :input_email, :string
      add :output_id, :binary_id 
      add :output_name, :string
      add :output_email, :string
      add :input_supul_id, :binary_id
      add :input_supul_name, :string
      add :output_supul_id, :binary_id
      add :output_supul_name, :string
      add :event_hash, :string 
      add :openhash_id, :binary_id
      add :payload, :text
      
      add :family_id, references(:families, type: :uuid)
      add :user_id, references(:users, type: :uuid)
      
      timestamps()
    end

  end
end
