defmodule Demo.Products do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Products.Product 
  alias Demo.Products.GPCCode
  alias Demo.Entities.Entity

  def create_category!(name) do
    Repo.insert!(%GPCCode{name: name}, on_conflict: :nothing)
  end
  
  def list_products() do
    Repo.all(Product)
  end 




  def get_product!(id), do: Repo.get!(Product, id)


  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    IO.puts "delete_product"
    
    Repo.delete(product)
  end 

  def create_product(%Entity{} = entity, attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  

  def create_GPCCode(attrs \\ %{}) do
    %GPCCode{}
    |> GPCCode.changeset(attrs)
    |> Repo.insert()
  end

  alias Demo.Gabs.Gab
  def create_product(%Gab{} = gab, attrs) do
    %Product{}
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:gab, gab)
    |> Repo.insert()
  end

  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end

  alias Demo.Products.ProductAnnotation

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
