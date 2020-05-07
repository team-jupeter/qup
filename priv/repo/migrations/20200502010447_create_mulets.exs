defmodule Demo.Repo.Migrations.CreateMulets do
  use Ecto.Migration

  def change do
    create table(:mulets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :sil, :string
      add :supul_id, references(:supuls, type: :uuid, null: false)

      timestamps()
    end

  end
end
