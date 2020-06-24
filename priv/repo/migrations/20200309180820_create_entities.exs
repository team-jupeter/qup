defmodule Demo.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :registered_no, :string
      add :industry_classification, :string
      add :name, :string 
      add :email, :string
      add :gps, {:array, :map}
      add :nationality, :string
      add :company_prefix, :string
      add :entity_address, :string
      add :entity_code, :string
      add :founding_date, :date
      add :sic_code, :string 
      add :legal_status, :string 
      add :year_started, :integer
      add :year_ended, :integer
      add :num_of_shares, {:array, :map}
      add :share_price, {:array, :map}
      add :credit_rate, :string #? AAA, ..., FFF => 24 rates
      
      add :locked, :boolean, default: false
      add :nation_signature, :text

      add :gab_balance, :decimal, default: 0.0

      add :nation_id, references(:nations, type: :uuid)
      add :supul_id, references(:supuls, type: :uuid)
      add :state_supul_id, references(:state_supuls, type: :uuid)
      add :nation_supul_id, references(:nation_supuls, type: :uuid)
      add :taxation_id, references(:taxations, type: :uuid)
      add :invoice_id, references(:invoices, type: :uuid)
      add :biz_category_id, references(:biz_categories, type: :uuid)

      add(:business_embeds, {:array, :jsonb}, default: [])


      timestamps()
    end

  end
end
