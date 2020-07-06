defmodule Demo.Business.Products do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Business.Product 
  alias Demo.Business.GPCCode
  alias Demo.Business.Entity

  def create_category!(name) do
    Repo.insert!(%GPCCode{name: name}, on_conflict: :nothing)
  end
  
  def list_products() do
    Repo.all(Product)
  end

  def list_entity_products(%Entity{} = entity) do
    Product
    |> entity_products_query(entity)
    |> Repo.all()
  end

  def get_entity_product!(%Entity{} = entity, id) do
    Product
    |> entity_products_query(entity)
    |> Repo.get!(id)
  end 

  def get_product!(id), do: Repo.get!(Product, id)

  defp entity_products_query(query, %Entity{id: entity_id}) do
    from(p in query, where: p.entity_id == ^entity_id)
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end 

  def create_product(%Entity{} = entity, attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  alias Demo.Business.ProductAnnotation

  def annotate_product(%Entity{id: entity_id}, product_id, attrs) do 
    %ProductAnnotation{product_id: product_id, entity_id: entity_id}
    |> ProductAnnotation.changeset(attrs)
    |> Repo.insert()
  end

  def list_annotations(%Product{} = product) do
    Repo.all(
      from a in Ecto.assoc(product, :product_annotations),
        order_by: [asc: a.at, asc: a.id],
        limit: 500,
        preload: [:entity]
    )
  end
end
