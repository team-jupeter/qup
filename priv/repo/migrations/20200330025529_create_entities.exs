defmodule Demo.Repo.Migrations.CreateEntities do
  use Ecto.Migration

  def change do
    create table(:entities, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :string
      add :category, :string
      add :year_started, :integer
      add :year_ended, :integer
      add :share_price, :integer
      add :balance, :decimal, default: 0
      add :locked, :boolean, default: false

      add :nation_id, references(:nations, type: :uuid)
      add :supul_id, references(:supuls, type: :uuid)
      add :tax_authority_id, references(:tax_authorities, type: :uuid)
      add :bank_id, references(:banks, type: :uuid)
      add :invoice_id, references(:invoices, type: :uuid)

      timestamps()
    end

  end
end
