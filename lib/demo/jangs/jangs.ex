defmodule Demo.Jangs do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Jangs.Jang
  alias Demo.Products.Product

  def list_jangs do
    Repo.all(Jang)
  end

  def list_products do
    Repo.all(Product)
  end

  def get_jang!(id), do: Repo.get!(Jang, id)


  def create_jang(attrs \\ %{}) do
    %Jang{}
    |> Jang.changeset(attrs)
    |> Repo.insert()
  end

  def update_jang(%Jang{} = jang, attrs) do
    jang
    |> Jang.changeset(attrs)
    |> Repo.update()
  end

  def delete_jang(%Jang{} = jang) do
    Repo.delete(jang)
  end


  def change_jang(%Jang{} = jang) do
    Jang.changeset(jang, %{})
  end
end
