defmodule Demo.Repo.Migrations.CreateApplicants do
  use Ecto.Migration

  def change do
    create table(:applicants, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :names, {:array, :map}
      add :amount, :integer

      timestamps()
    end

  end
end
