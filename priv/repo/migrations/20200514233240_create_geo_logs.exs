defmodule Demo.Repo.Migrations.CreateGeoLogs do
  use Ecto.Migration

  def change do
    create table(:geo_logs) do
      add :latitude, :string
      add :longitude, :string
      add :altitude, :string
      add :date_time, :naive_datetime

      add :user_id, references(:users, type: :uuid, null: false)

      timestamps()
    end

  end
end
