defmodule Demo.Repo.Migrations.CreateJangs do
  use Ecto.Migration

  def change do
    create table(:jangs) do
      add :cart, :string

      timestamps()
    end

  end
end
