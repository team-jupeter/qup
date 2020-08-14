defmodule Demo.Repo.Migrations.CreateWithdrawals do
  use Ecto.Migration

  def change do
    create table(:withdrawals, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add :input_name, :string
      add :input_id, :binary_id
      add :input_tel, :string
      add :input_email, :string
      add :input_currency, :string
      add :input_amount, :decimal, precision: 12, scale: 2, default: 0.0
      
      add :output_name, :string
      add :output_id, :binary_id
      add :output_tel, :string
      add :output_email, :string
      add :output_currency, :string
      add :output_bank, :string
      add :output_bank_account, :string
      add :output_amount, :decimal, precision: 12, scale: 2, default: 0.0
  
      add(:entity_id, references(:entities, type: :uuid))
      add(:gab_account_id, references(:gab_accounts, type: :uuid))

      timestamps()
    end

  end
end
