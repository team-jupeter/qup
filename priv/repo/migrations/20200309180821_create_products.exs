defmodule Demo.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    
    create table(:products, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :gpc_code, :string
      add :price, :decimal
      add :gopang_fee, :string
      add :tax, :decimal
      add :insurance, :string
      add :stars, :decimal
      add :comments, {:array, :map}
      add :pvr, :decimal
      

      timestamps()
    end

  end
end
