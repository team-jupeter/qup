defmodule Demo.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :type, :string
      add :auth_code, :string
      add :industry_classification, :string
      add :name, :string 
      add :unique_digits, :string
      add :telephones, {:array, :string}
      add :project, :string 
      add :supul_name, :string 
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
      add :supul_code, :binary_id 
      add :taxation_code, :binary_id 
      
      add :password_hash, :string
      
      add :locked, :boolean, default: false
      add :nation_signature, :text
      
      add :t1_balance, :decimal, precision: 12, scale: 4, default: 0.0
      
      add :default_group, :boolean, default: false
      add :default_currency, :string, default: "KRW"

      # add :user_id, references(:users, type: :uuid)
      add :gab_id, references(:gabs, type: :uuid)
      add :nation_id, references(:nations, type: :uuid)
      add :family_id, references(:families, type: :uuid)
      add :group_id, references(:groups, type: :uuid)
      add :supul_id, references(:supuls, type: :uuid)
      add :state_supul_id, references(:state_supuls, type: :uuid)
      add :nation_supul_id, references(:nation_supuls, type: :uuid)
      add :taxation_id, references(:taxations, type: :uuid)
      add :biz_category_id, references(:biz_categories, type: :uuid)
      
      add(:business_embeds, {:array, :jsonb}, default: [])
      
      #? many to many
      # add :invoice_id, references(:invoices, type: :uuid)
      # add :transaction_id, references(:invoices, type: :uuid)

      timestamps()
    end

  end
end
