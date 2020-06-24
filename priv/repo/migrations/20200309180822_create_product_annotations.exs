defmodule Demo.Repo.Migrations.CreateProductAnnotations do
  use Ecto.Migration

  def change do
    create table(:product_annotations) do
      add :body, :text
      add :at, :integer
      add :star, :integer

      add :entity_id, references(:entities, type: :uuid, on_delete: :nothing)
      add :product_id, references(:products, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:product_annotations, [:entity_id])
    create index(:product_annotations, [:product_id])
  end
end
