defmodule Demo.Repo.Migrations.CreateTransfers do
  use Ecto.Migration

  def change do
    create table(:transfers, primary_key: false) do
      add(:id, :uuid, primary_key: true)
      add(:type, :string)
      add(:input_id, :binary_id)
      add(:input_name, :string)
      add(:input_email, :string)
      add(:input_tel, :string)
      add(:input_gab, :string)
      add(:input_supul_id, :binary_id)
      add(:input_state_supul_id, :binary_id)
      add(:input_nation_supul_id, :binary_id)

      add(:input_currency, :string)
      add(:input_amount, :decimal, precision: 15, scale: 4)

      add(:output_id, :binary_id)
      add(:output_name, :string)
      add(:output_email, :string)
      add(:output_tel, :string)
      add(:output_gab, :string)
      add(:output_supul_id, :binary_id)
      add(:output_state_supul_id, :binary_id)
      add(:output_nation_supul_id, :binary_id)

      add(:output_currency, :string)
      add(:output_amount, :decimal, precision: 15, scale: 4)

      add(:fair?, :boolean, default: false)

      add(:entity_id, references(:entities, type: :uuid))

      timestamps()
    end
  end
end
