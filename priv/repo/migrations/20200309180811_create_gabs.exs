defmodule Demo.Repo.Migrations.CreateGabs do
  use Ecto.Migration

  def change do
    create table(:gabs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :unique_digits, :string
      add :tels, {:array, :string}
  
      add :t1_balance, :decimal, precision: 20, scale: 4, default: 0.0
      add :t2_balance, :decimal, precision: 20, scale: 4, default: 0.0
      add :t3_balance, :decimal, precision: 20, scale: 4, default: 0.0
      add :t4_balance, :decimal, precision: 20, scale: 4, default: 0.0
      add :t5_balance, :decimal, precision: 20, scale: 4, default: 0.0

      add :supul_id, references(:supuls, type: :uuid)
      add :state_supul_id, references(:state_supuls, type: :uuid)
      add :nation_supul_id, references(:nation_supuls, type: :uuid)
      add :nation_id, references(:nations, type: :uuid)

      timestamps()
    end

  end
end
