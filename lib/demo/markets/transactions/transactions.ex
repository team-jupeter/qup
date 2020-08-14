defmodule Demo.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo
  # alias Demo.Supuls
  # alias Demo.Transactions
  alias Demo.Transactions.Transaction
  alias Demo.Entities.Entity

  def list_transactions(%Entity{} = entity) do
    Transaction
    |> entity_transactions_query(entity)
    |> Repo.all()
  end

  def get_entity_transaction!(id) do
    Transaction
    # |> entity_transactions_query(entity)
    |> Repo.get!(id)
  end 

  defp entity_transactions_query(query, entity) do
    from(t in query,
      where: t.input_id == ^entity.id or t.ssu_id == ^entity.id,
      select: t
    )
  end

  def get_transaction!(id), do: Repo.get!(Transaction, id)

  def create_transaction(attrs) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end
 
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction = Repo.preload(transaction, :openhash)

    transaction
    |> Transaction.changeset_openhash(attrs)
    |> Repo.update()
  end

  def add_openhash(%Transaction{} = transaction, attrs) do
    Repo.preload(transaction, :openhash) |> Transaction.changeset_openhash(attrs)
  end

  def archive_transaction(%Transaction{} = transaction) do
    Transaction.changeset(transaction, %{archived: true})
  end

  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  def change_transaction(%Transaction{} = transaction) do
    Transaction.changeset(transaction, %{})
  end
end
