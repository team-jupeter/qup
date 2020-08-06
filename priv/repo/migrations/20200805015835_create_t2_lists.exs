defmodule Demo.Repo.Migrations.CreateT2Lists do
  use Ecto.Migration

  def change do
    create table(:t2_lists, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :USD, :decimal, default: 0.0
      add :EUR, :decimal, default: 0.0
      add :JPY, :decimal, default: 0.0
      add :GBP, :decimal, default: 0.0
      add :AUD, :decimal, default: 0.0
      add :CAD, :decimal, default: 0.0
      add :CHF, :decimal, default: 0.0
      add :CNY, :decimal, default: 0.0
      add :SEK, :decimal, default: 0.0
      add :MXN, :decimal, default: 0.0
      add :NZD, :decimal, default: 0.0
      add :SGD, :decimal, default: 0.0
      add :HKD, :decimal, default: 0.0
      add :NOK, :decimal, default: 0.0
      add :KRW, :decimal, default: 0.0

      add :gab_id, references(:gabs, type: :uuid)
      add :entity_id, references(:tntities, type: :uuid)

      timestamps()
    end

  end
end
