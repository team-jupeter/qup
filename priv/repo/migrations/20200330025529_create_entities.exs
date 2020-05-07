defmodule Demo.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string, null: false
      add :category, :string
      add :year_started, :integer
      add :year_ended, :integer
      add :share_price, :integer
      add :balance, :decimal, null: false, default: 0
      add :locked, :boolean, null: false, default: false

      add :nation_id, references(:nations, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :tax_id, references(:tax_authorities, type: :uuid, null: false)
      add :bank_id, references(:banks, type: :uuid, null: false)
      add :invoice_id, references(:invoices, type: :uuid, null: false)

      timestamps()
    end

  end
end
