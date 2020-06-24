defmodule Demo.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do 
      add :url, :string
      add :title, :string
      add :description, :text
      add :slug, :string

      add :user_id, references(:users, type: :uuid, on_delete: :nothing)
      add :product_id, references(:products, type: :uuid, on_delete: :nothing)
      add :category_id, references(:categories, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:videos, [:user_id])
  end
end
