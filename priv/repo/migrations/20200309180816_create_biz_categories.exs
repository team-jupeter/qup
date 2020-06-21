defmodule Demo.Repo.Migrations.CreateBizCategories do
  use Ecto.Migration

  def change do
    create table(:biz_categories, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :standard, :string
      add :name, :string
      add :code, :string

      timestamps()
    end

  end
end
