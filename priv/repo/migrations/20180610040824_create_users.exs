defmodule Demo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:username, :string)
      add(:email, :string)
      add(:phone_number, :string)
      add(:password_hash, :string)
      add(:balance, :integer)

      timestamps()
    end

    create(unique_index(:users, [:username]))
  end
end
