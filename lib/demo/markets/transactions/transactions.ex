defmodule Demo.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo
  # alias Demo.Supuls
  # alias Demo.Transactions
  alias Demo.Transactions.Transaction
  alias Demo.Business.Entity

  def list_transactions(%Entity{} = entity) do
    Transaction
    |> entity_transactions_query(entity)
    |> Repo.all()
  end

  
  def get_entity_transaction!(id) do
    IO.puts "get_entity_transaction"
    Transaction
    # |> entity_transactions_query(entity)
    |> Repo.get!(id) 
  end
  defp entity_transactions_query(query, entity) do
    from(t in query, 
    where: t.buyer_id == ^entity.id or t.seller_id == ^entity.id,
    select: t)
  end
  
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  
  def create_transaction(attrs, buyer_private_key, seller_private_key) do  
    {:ok, transaction} = %Transaction{} 
    |> Transaction.changeset(attrs)  
    |> Repo.insert

    Demo.Events.create_event(transaction, buyer_private_key, seller_private_key)
  end 



  def update_transaction(%Transaction{} = transaction, attrs) do
    IO.inspect "update_transaction"
    IO.inspect attrs
    
    transaction = Repo.preload(transaction, :openhash)
    transaction
    |> Transaction.changeset_openhash(attrs)
    |> Repo.update()
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
