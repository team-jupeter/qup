defmodule Demo.Repo.Migrations.CreateT1s do
  use Ecto.Migration

  def change do
    create table(:t1s, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :openhash_id, :binary_id
      add :input_name, :string
      add :input_id, :string
      add :output_name, :string
      add :output_id, :string
      add :amount, :decimal, precision: 12, scale: 2
      add :currency, :string

      add :entity_id, references(:entities, type: :uuid)

      timestamps()
    end

  end
end
