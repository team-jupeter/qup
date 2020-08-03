defmodule Demo.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:type, :string)
      # ? previous transaction_id and digital signature of invoice
      add(:hash_of_invoice, :string)

      add(:erl_type, :string)
      add(:ssu_type, :string)

      # ? who pays ABC? which ts in his/her/its wallet?
      add(:erl_id, :binary_id)
      add(:erl_name, :string)
      add(:erl_email, :string)
      add(:erl_family_id, :binary_id)
      add(:erl_group_id, :binary_id)
      add(:erl_supul_id, :binary_id)
      add(:erl_state_supul_id, :binary_id)
      add(:erl_nation_supul_id, :binary_id)

      add(:ssu_id, :binary_id)
      add(:ssu_name, :string)
      add(:ssu_email, :string)
      add(:ssu_family_id, :binary_id)
      add(:ssu_group_id, :binary_id)
      add(:ssu_supul_id, :binary_id)
      add(:ssu_state_supul_id, :binary_id)
      add(:ssu_nation_supul_id, :binary_id)

      add(:gps, {:array, :map})
      add(:tax, :decimal, default: 0.0)
      add(:gopang_fee, :decimal, default: 0.0)
      add(:insurance, :string)

      add(:abc_input_id, :binary_id)
      add(:abc_input_name, :string)
      add(:abc_output_id, :binary_id)
      add(:abc_output_name, :string)
      add(:abc_input_ts, {:array, :map}, default: [])
      add(:abc_amount, :decimal, precision: 15, scale: 4)

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
