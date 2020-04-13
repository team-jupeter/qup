defmodule Demo.Repo.Migrations.CreateBuyers do
  use Ecto.Migration

  def change do
    create table(:buyers) do
      add :name, :string

      add :user_id, references(:users)
      add :trade_id, references(:trades)

      timestamps()
    end

  end
end
