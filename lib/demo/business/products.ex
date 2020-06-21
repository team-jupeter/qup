defmodule Demo.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Business.Product
  alias Demo.Business.GPCCode

  def create_gpc_code!(standard, name, code) do
    Repo.insert!(%GPCCode{standard: standard, name: name, code: code}, on_conflict: :nothing)
  end

  def list_products do
    Repo.all(Product)
  end

  def get_product!(id), do: Repo.get!(Product, id)

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  def change_product(%Product{} = product) do
    Product.changeset(product, %{})
  end
end
