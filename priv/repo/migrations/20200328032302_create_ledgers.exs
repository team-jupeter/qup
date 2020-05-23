defmodule Demo.Repo.Migrations.CreateLedgers do
  use Ecto.Migration

  
   
  def change do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";"
    create table(:ledgers, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v5(uuid_generate_v4(), '#{System.get_env("UUID_V5_SECRET")}')"), read_after_writes: true
      

      timestamps()
    end

  end
end
