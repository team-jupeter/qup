defmodule Demo.Repo.Migrations.CreateT4Lists do
  use Ecto.Migration

  def change do
    create table(:t4_lists, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :NYSE, :string
      add :NASDAQ, :string
      add :JPX, :string
      add :LSE, :string
      add :SSE, :string
      add :SEHK, :string
      add :ENX, :string
      add :SZSE, :string
      add :TSX, :string
      add :BSE, :string
      add :NSE, :string
      add :DB, :string
      add :SIX, :string
      add :KRX, :string

      add :gab_id, references(:gabs, type: :uuid)
      add :entity_id, references(:tntities, type: :uuid)

      timestamps()
    end

  end
end
