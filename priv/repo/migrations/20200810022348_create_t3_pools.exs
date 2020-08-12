defmodule Demo.Repo.Migrations.CreateT3Pools do
  use Ecto.Migration

  def change do
    create table(:t3_pools, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :num_of_issues, :integer

      add :gab_id, references(:gabs, type: :uuid)
 
      timestamps()
    end

  end
end
 