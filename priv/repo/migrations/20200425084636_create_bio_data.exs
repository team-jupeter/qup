defmodule Demo.Repo.Migrations.CreateBioData do
  use Ecto.Migration

  def change do
    create table(:bio_data, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :weight, :string
      add :fingerprint, :string
      add :footprint, :string
      add :blood_type, :string
      add :blood_pressure, :string
      add :dna, :string
      add :medic_treatments, :string
      add :vision, :string
      add :iris_pattern, :string
      add :blood_sugar, :string
      add :health_status, :string

      timestamps()
    end

  end
end
