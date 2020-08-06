defmodule Demo.T3Lists do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T3Lists.T3List


  def list_t3_lists do
    Repo.all(T3List)
  end

  def get_t3_list!(id), do: Repo.get!(T3List, id)

  def create_t3_list(attrs \\ %{}) do
    %T3List{}
    |> T3List.changeset(attrs)
    |> Repo.insert()
  end

  def update_t3_list(%T3List{} = t3_list, attrs) do
    t3_list
    |> T3List.changeset(attrs)
    |> Repo.update()
  end

  def delete_t3_list(%T3List{} = t3_list) do
    Repo.delete(t3_list)
  end

  def change_t3_list(%T3List{} = t3_list) do
    T3List.changeset(t3_list, %{})
  end

  def buy_t3(amount_to_buy) do
  end
end
