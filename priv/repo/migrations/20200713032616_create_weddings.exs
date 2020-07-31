defmodule Demo.Repo.Migrations.CreateWeddings do
  use Ecto.Migration

  def change do
    create table(:weddings, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :erl_id, :binary_id
      add :erl_name, :string
      add :erl_email, :string
      add :ssu_id, :binary_id 
      add :ssu_name, :string
      add :ssu_email, :string
      add :erl_supul_id, :binary_id
      add :erl_supul_name, :string
      add :ssu_supul_id, :binary_id
      add :ssu_supul_name, :string
      add :event_hash, :string 
      add :openhash_id, :binary_id
      add :payload, :text
      
      add :family_id, references(:families, type: :uuid)
      add :user_id, references(:users, type: :uuid)
      
      timestamps()
    end

  end
end