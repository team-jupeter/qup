defmodule Demo.Trade do

##

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Trade.Transaction
  alias Demo.Accounts
  alias Demo.Accounts.User

  @topic inspect(__MODULE__)

  def subscribe do
    # IO.inspect @topic
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(transaction_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{transaction_id}")
  end

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%transaction{}, ...]

  """
  def list_transactions(current_page, per_page) do
    a = Repo.all(
      from t in Transaction,
        order_by: [asc: t.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
    IO.inspect a
    a
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:transaction, :created])
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:transaction, :updated])
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    transaction
    |> Repo.delete()
    |> notify_subscribers([:transaction, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{source: %transaction{}}

  """
  def change_transaction(transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  defp notify_subscribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}

  def upsert_user_transactions(user, transaction_ids) when is_list(transaction_ids) do
    transactions =
      Transaction
      |> where([transaction], transaction.id in ^transaction_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           user
           |> User.changeset_update_transactions(transactions)
           |> Repo.update() do
      {:ok, Accounts.get_user!(user.id)}
    else
      error ->
        error
    end
  end
end

