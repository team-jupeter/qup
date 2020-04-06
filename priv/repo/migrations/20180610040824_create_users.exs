defmodule Demo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:type, :string)
      add(:name, :string)
      add(:email, :string)
      add(:password_hash, :string)
      add(:balance, :integer)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
