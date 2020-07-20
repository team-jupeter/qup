defmodule Demo.Repo.Migrations.CreateWeddings do
  use Ecto.Migration

  def change do
    create table(:weddings, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :bride_id, :binary_id
      add :bride_name, :string
      add :bride_email, :string
      add :groom_id, :binary_id 
      add :groom_name, :string
      add :groom_email, :string
      add :erl_supul_id, :binary_id
      add :ssu_supul_id, :binary_id
      add :event_hash, :string 
      
      timestamps()
    end

  end
end
