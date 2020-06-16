defmodule Demo.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :company_prefix, :string
      add :registered_no, :string
      add :industry_classification, :string
      add :entity_address, :string
      add :entity_code, :string
      add :name, :string
      add :email, :string
      add :founding_date, :date

      add :locked, :boolean, default: false

      add :private_key, :string
      add :public_key, :string

      add :gab_balance, :decimal, default: 0.0

      add :nation_id, references(:nations, type: :uuid)
      add :supul_id, references(:supuls, type: :uuid)
      add :taxation_id, references(:taxations, type: :uuid)
      add :invoice_id, references(:invoices, type: :uuid)

      add(:business_embeds, {:array, :jsonb}, default: [])


      timestamps()
    end

  end
end
