defmodule Demo.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:type, :string)
      # ? previous transaction_id and digital signature of invoice
      add(:hash_of_invoice, :string)

      add(:input_type, :string)
      add(:output_type, :string)

      # ? who pays ABC? which ts in his/her/its wallet?
      add(:input_id, :binary_id)
      add(:input_name, :string)
      add(:input_email, :string)
      add(:input_family_id, :binary_id)
      add(:input_group_id, :binary_id)
      add(:input_supul_id, :binary_id)
      add(:input_state_supul_id, :binary_id)
      add(:input_nation_supul_id, :binary_id)

      add(:output_id, :binary_id)
      add(:output_name, :string)
      add(:output_email, :string)
      add(:output_family_id, :binary_id)
      add(:output_group_id, :binary_id)
      add(:output_supul_id, :binary_id)
      add(:output_state_supul_id, :binary_id)
      add(:output_nation_supul_id, :binary_id)

      add(:gps, {:array, :map})
      add(:tax, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:gopang_fee, :decimal, precision: 12, scale: 4, default: 0.0)
      add(:insurance, :string)

      add(:t1_input_id, :binary_id)
      add(:t1_input_name, :string)
      add(:t1_output_id, :binary_id)
      add(:t1_output_name, :string)
      add(:t1_input_ts, {:array, :map}, default: [])
      add(:t1_amount, :decimal, precision: 15, scale: 4)

      add(:items, {:array, :binary_id})
      add(:fiat_currency, :decimal, precision: 15, scale: 4)
      # ? processing, pending, completed
      add(:transaction_status, :string, default: "Processing...")
      add(:if_only_item, :string)
      add(:fair?, :boolean, default: false)

      add(:supul_code, :integer, default: 0)
      add(:event_hash, :string)

      add(:locked?, :boolean, default: false)
      add(:archived?, :boolean, default: false)
      add(:payload, :string)
      add(:payload_hash, :string)

      add(:invoice_id, references(:invoices, type: :uuid, null: false))

      # add :locked, :boolean, default: false
      # add :locking_use_area, {:array, :string}, default: []
      # add :locking_use_until, :naive_datetime
      # add :locking_output_entity_catetory, {:array, :string}, default: []
      # add :locking_output_specific_entities, {:array, :string}, default: []

      timestamps()
    end
  end
end
