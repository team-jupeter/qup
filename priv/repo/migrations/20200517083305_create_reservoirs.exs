defmodule Demo.Repo.Migrations.CreateReservoirs do
  use Ecto.Migration

  def change do
    create table(:reservoirs, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :abc_t1, :decimal, precision: 20, scale: 2, default: 0.0
      add :abc_t2, :decimal, precision: 20, scale: 2, default: 0.0
      add :abc_t3, :decimal, precision: 20, scale: 2, default: 0.0
      
      add :f0, :decimal, precision: 20, scale: 2, default: 0.0
      add :f1, :decimal, precision: 20, scale: 2, default: 0.0
      add :f7, :decimal, precision: 20, scale: 2, default: 0.0
      add :f33, :decimal, precision: 20, scale: 2, default: 0.0
      add :f34, :decimal, precision: 20, scale: 2, default: 0.0
      add :f44, :decimal, precision: 20, scale: 2, default: 0.0
      add :f49, :decimal, precision: 20, scale: 2, default: 0.0
      add :f61, :decimal, precision: 20, scale: 2, default: 0.0
      add :f65, :decimal, precision: 20, scale: 2, default: 0.0
      add :f81, :decimal, precision: 20, scale: 2, default: 0.0
      add :f82, :decimal, precision: 20, scale: 2, default: 0.0
      add :f84, :decimal, precision: 20, scale: 2, default: 0.0
      add :f86, :decimal, precision: 20, scale: 2, default: 0.0
      add :f852, :decimal, precision: 20, scale: 2, default: 0.0
      add :f886, :decimal, precision: 20, scale: 2, default: 0.0
      add :f972, :decimal, precision: 20, scale: 2, default: 0.0

      timestamps()
    end

  end
end
