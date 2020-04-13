defmodule Demo.Repo.Migrations.CreateBanks do
  use Ecto.Migration

  def change do
    create table(:banks) do
      add :name, :string
      add :nationality, :string

      add :nation_id, references(:nations)

      timestamps()
    end

  end
end
