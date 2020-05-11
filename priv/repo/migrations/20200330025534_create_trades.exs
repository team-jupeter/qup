defmodule Demo.Repo.Migrations.CreateInvoice do
  use Ecto.Migration

  def change do
    create table(:trades) do

      add :invoice_id, references(:invoices, type: :uuid, null: false)
      add :supul_id, references(:supuls, type: :uuid, null: false)
      add :taxation_id, references(:taxations, type: :uuid, null: false)

      timestamps()
    end

  end
end
