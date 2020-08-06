defmodule Demo.Repo.Migrations.CreateT3s do
  use Ecto.Migration

  def change do
    create table(:t3s, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :current_owner, :string
      add :price, :string

      add :gab_id, references(:gabs, type: :uuid)
      add :entity_id, references(:tntities, type: :uuid)

      timestamps()
    end

  end
end
