defmodule Demo.Repo.Migrations.CreateOpenhashes do
  use Ecto.Migration

  def change do
    create table(:openhashes) do
      add :payload_hash, :text
      add :chained_hash, :text, default: "origin"

      timestamps() 
    end

  end
end
