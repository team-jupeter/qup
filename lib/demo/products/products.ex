# context
defmodule Demo.Products do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Products.Product
  # alias Demo.Trades.Trade

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(product_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{product_id}")
  end

  def list_products, do: Repo.all(Product)

  def get_product(id), do: Repo.get(Product, id)

  def get_product!(id), do: Repo.get!(Product, id)

  def get_product_by(params), do: Repo.get_by(Product, params)

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:product, :created])
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:product, :updated])
  end

  def delete_product(%Product{} = product) do
    product
    |> Repo.delete()
    |> notify_subscribers([:product, :deleted])
  end

  def change_product(product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  def register_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end


  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
