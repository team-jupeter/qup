defmodule Demo.Repo.Migrations.CreateSellers do
  use Ecto.Migration

  def change do
    create table(:sellers) do
      add :name, :string

      add :user_id, references(:users)
      add :trade_id, references(:trades)

      timestamps()
    end

  end
end
