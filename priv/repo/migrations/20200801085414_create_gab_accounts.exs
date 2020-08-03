defmodule Demo.Repo.Migrations.CreateGabAccounts do
  use Ecto.Migration

  def change do
    create table(:gab_accounts) do
      add :owner, :string
      add :t1, :string
      add :t2, :string
      add :t3, :string
      add :credit_limit, :string

      timestamps()
    end

  end
end
