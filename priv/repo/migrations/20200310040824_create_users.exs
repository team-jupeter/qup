defmodule Demo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uid, :integer
      add :type, :string
      add :name, :string
      add :email, :string
      add :nationality, :string
      add :password_hash, :string
      add :balance, :integer

      add :fingerprint, :integer
      add :face, :integer
      add :weight, :integer
      add :height, :integer

      add :buyer, :boolean
      add :seller, :boolean
      add :birth_date, :date

      add :tax_id, references(:taxes)
      add :bank_id, references(:banks)
      add :unit_supul_id, references(:unit_supuls)
      add :team_id, references(:teams)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
