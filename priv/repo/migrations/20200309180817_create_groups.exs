defmodule Demo.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :t1_balance, :decimal, precision: 12, scale: 4, default: 0.0
      add :type, :string
      add :name, :string

      add :supul_id, references(:supuls, type: :uuid)
      
      timestamps()
    end

  end
end
