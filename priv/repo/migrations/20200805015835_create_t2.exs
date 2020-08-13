defmodule Demo.Repo.Migrations.CreateT2s do
  use Ecto.Migration

  def change do
    create table(:t2s, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :usd, :decimal, precision: 12, scale: 4, default: 0.0
      add :eur, :decimal, precision: 12, scale: 4, default: 0.0
      add :jpy, :decimal, precision: 12, scale: 4, default: 0.0
      add :gbp, :decimal, precision: 12, scale: 4, default: 0.0
      add :aud, :decimal, precision: 12, scale: 4, default: 0.0
      add :cad, :decimal, precision: 12, scale: 4, default: 0.0
      add :chf, :decimal, precision: 12, scale: 4, default: 0.0
      add :cny, :decimal, precision: 12, scale: 4, default: 0.0
      add :sek, :decimal, precision: 12, scale: 4, default: 0.0
      add :mxn, :decimal, precision: 12, scale: 4, default: 0.0
      add :nzd, :decimal, precision: 12, scale: 4, default: 0.0
      add :sgd, :decimal, precision: 12, scale: 4, default: 0.0
      add :hkd, :decimal, precision: 12, scale: 4, default: 0.0
      add :nok, :decimal, precision: 12, scale: 4, default: 0.0
      add :krw, :decimal, precision: 12, scale: 4, default: 0.0

      add :gab_account_id, references(:gab_accounts, type: :uuid)
      add :gab_id, references(:gabs, type: :uuid)
      add :entity_id, references(:entities, type: :uuid)

      timestamps()
    end

  end
end
