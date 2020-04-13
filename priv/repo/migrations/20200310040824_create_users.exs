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

      # add :bank_id, references(:banks)
      add :tax_id, references(:taxes)
      add :nation_id, references(:nations)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
