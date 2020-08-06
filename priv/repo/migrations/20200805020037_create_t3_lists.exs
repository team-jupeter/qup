defmodule Demo.Repo.Migrations.CreateT3Lists do
  use Ecto.Migration

  def change do
    create table(:t3_lists, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :num_of_stocks, :string
      add :price_per_share, :string
      
      add :gab_id, references(:gabs, type: :uuid)
      add :entity_id, references(:tntities, type: :uuid)

      timestamps()
    end

  end
end
