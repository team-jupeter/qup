defmodule Demo.Repo.Migrations.CreateT2Pools do
  use Ecto.Migration

  def change do
    create table(:t2_pools, primary_key: false) do
      add :id, :uuid, primary_key: true
      
      add :usd, :decimal, precision: 20, scale: 4, default: 0.0
      add :eur, :decimal, precision: 20, scale: 4, default: 0.0
      add :jpy, :decimal, precision: 20, scale: 4, default: 0.0
      add :gbp, :decimal, precision: 20, scale: 4, default: 0.0
      add :aud, :decimal, precision: 20, scale: 4, default: 0.0
      add :cad, :decimal, precision: 20, scale: 4, default: 0.0
      add :chf, :decimal, precision: 20, scale: 4, default: 0.0
      add :cny, :decimal, precision: 20, scale: 4, default: 0.0
      add :sek, :decimal, precision: 20, scale: 4, default: 0.0
      add :mxn, :decimal, precision: 20, scale: 4, default: 0.0
      add :nzd, :decimal, precision: 20, scale: 4, default: 0.0
      add :sgd, :decimal, precision: 20, scale: 4, default: 0.0
      add :hkd, :decimal, precision: 20, scale: 4, default: 0.0
      add :nok, :decimal, precision: 20, scale: 4, default: 0.0
      add :krw, :decimal, precision: 20, scale: 4, default: 0.0

      add :gab_id, references(:gabs, type: :uuid)

      timestamps()
    end

  end
end
