defmodule Demo.Repo.Migrations.CreateTels do
  use Ecto.Migration

  def change do
    create table(:tels, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :unique_digits, :string
      add :telephone_nums, {:array, :string}

      add :gab_account_id, references(:gab_accounts, type: :uuid)
      add :entity_id, references(:entities, type: :uuid)
      add :supul_id, references(:supuls, type: :uuid)
      add :nation_id, references(:nations, type: :uuid)

      
      timestamps()
    end
    create unique_index(:tels, [:unique_digits])
  end
end
