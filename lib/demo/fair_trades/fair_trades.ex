defmodule Demo.FairTrades do
  @moduledoc """
  The FairTrades context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.FairTrades.FairTrade

  @doc """
  Returns the list of fair_trades.

  ## Examples

      iex> list_fair_trades()
      [%FairTrade{}, ...]

  """
  def list_fair_trades do
    Repo.all(FairTrade)
  end

  @doc """
  Gets a single fair_trade.

  Raises `Ecto.NoResultsError` if the Fair trade does not exist.

  ## Examples

      iex> get_fair_trade!(123)
      %FairTrade{}

      iex> get_fair_trade!(456)
      ** (Ecto.NoResultsError)

  """
  def get_fair_trade!(id), do: Repo.get!(FairTrade, id)

  @doc """
  Creates a fair_trade.

  ## Examples

      iex> create_fair_trade(%{field: value})
      {:ok, %FairTrade{}}

      iex> create_fair_trade(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_fair_trade(attrs \\ %{}) do
    %FairTrade{}
    |> FairTrade.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a fair_trade.

  ## Examples

      iex> update_fair_trade(fair_trade, %{field: new_value})
      {:ok, %FairTrade{}}

      iex> update_fair_trade(fair_trade, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_fair_trade(%FairTrade{} = fair_trade, attrs) do
    fair_trade
    |> FairTrade.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a fair_trade.

  ## Examples

      iex> delete_fair_trade(fair_trade)
      {:ok, %FairTrade{}}

      iex> delete_fair_trade(fair_trade)
      {:error, %Ecto.Changeset{}}

  """
  def delete_fair_trade(%FairTrade{} = fair_trade) do
    Repo.delete(fair_trade)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking fair_trade changes.

  ## Examples

      iex> change_fair_trade(fair_trade)
      %Ecto.Changeset{source: %FairTrade{}}

  """
  def change_fair_trade(%FairTrade{} = fair_trade) do
    FairTrade.changeset(fair_trade, %{})
  end
end
