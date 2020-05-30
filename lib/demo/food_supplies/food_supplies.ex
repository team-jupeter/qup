defmodule Demo.FoodSupplies do
  @moduledoc """
  The FoodSupplies context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.FoodSupplies.FoodSupply

  @doc """
  Returns the list of food_supplies.

  ## Examples

      iex> list_food_supplies()
      [%FoodSupply{}, ...]

  """
  def list_food_supplies do
    Repo.all(FoodSupply)
  end

  @doc """
  Gets a single food_supply.

  Raises `Ecto.NoResultsError` if the Food supply does not exist.

  ## Examples

      iex> get_food_supply!(123)
      %FoodSupply{}

      iex> get_food_supply!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_supply!(id), do: Repo.get!(FoodSupply, id)

  @doc """
  Creates a food_supply.

  ## Examples

      iex> create_food_supply(%{field: value})
      {:ok, %FoodSupply{}}

      iex> create_food_supply(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_food_supply(attrs \\ %{}) do
    %FoodSupply{}
    |> FoodSupply.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a food_supply.

  ## Examples

      iex> update_food_supply(food_supply, %{field: new_value})
      {:ok, %FoodSupply{}}

      iex> update_food_supply(food_supply, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_food_supply(%FoodSupply{} = food_supply, attrs) do
    food_supply
    |> FoodSupply.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a food_supply.

  ## Examples

      iex> delete_food_supply(food_supply)
      {:ok, %FoodSupply{}}

      iex> delete_food_supply(food_supply)
      {:error, %Ecto.Changeset{}}

  """
  def delete_food_supply(%FoodSupply{} = food_supply) do
    Repo.delete(food_supply)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking food_supply changes.

  ## Examples

      iex> change_food_supply(food_supply)
      %Ecto.Changeset{source: %FoodSupply{}}

  """
  def change_food_supply(%FoodSupply{} = food_supply) do
    FoodSupply.changeset(food_supply, %{})
  end
end
