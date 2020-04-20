defmodule Demo.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :category, :string
      add :year_started, :integer
      add :year_ended, :integer
      add :gru_price, :integer
      
      timestamps()
    end

  end
end
