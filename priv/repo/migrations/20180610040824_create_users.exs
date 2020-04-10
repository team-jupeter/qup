defmodule Demo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:type, :string)
      add(:name, :string)
      add(:email, :string)
      add(:password_hash, :string)
      add(:balance, :integer)

      add :fingerprint, :boolean
      add :face, :boolean
      add :weight, :boolean
      add :height, :boolean

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
