defmodule Demo.Repo.Migrations.CreateT5s do
  use Ecto.Migration

  def change do
    create table(:t5s, primary_key: false) do
      add(:price, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:current_owner, :string)
      add(:issuer, :string)
      add(:issuer_code, :string)
      add(:number_of_issues, :string)

      add(:put_price, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:call_price, :decimal, precision: 12, scale: 4, default: 0.0)

      add(:issued_at, :date)
      add(:putable_from, :date)
      add(:callable_from, :date)

      add(:entity_id, references(:entities, type: :uuid))
      add(:gab_account_id, references(:gab_accounts, type: :uuid))
      # add(:gab_id, references(:gabs, type: :uuid))
      add(:balance_sheet_id, references(:balance_sheets, type: :uuid))

      timestamps()
    end
  end
end
