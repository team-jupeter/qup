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

  
  def create_transaction(attrs) do  
    %Transaction{}
    |> Transaction.changeset(attrs)  
    |> Repo.insert
    |> IO.inspect
    # |> make_payload_and_send_to_supul(buyer_rsa_priv_key, sender_rsa_priv_key) #? if fail, the code below is not called.
  end 

  def make_payload(transaction, buyer_rsa_priv_key, sender_rsa_priv_key) do
    ts = DateTime.utc_now() |> DateTime.to_unix()
    txn_id = transaction.id 

    txn_serialized = Poison.encode!(transaction)
    txn_hash = Pbkdf2.hash_pwd_salt(txn_serialized)
    # txn_hash_serialized =  Poison.encode!(txn_hash)

    Transaction.changeset(transaction, %{txn_hash: txn_hash})
    |> Repo.update()

    # txn_msg = "#{ts}|#{txn_id}|#{txn_hash_serialized}"
    txn_msg = "#{ts}|#{txn_id}|#{txn_hash}"

    {:ok, buyer_signature} = ExPublicKey.sign(txn_msg, buyer_rsa_priv_key)
    {:ok, seller_signature} = ExPublicKey.sign(txn_msg, sender_rsa_priv_key)

    IO.puts "Hi, I am here...smile ^^*"
    # payload = "#{ts}|#{txn_id}|#{txn_hash_serialized}|#{Base.url_encode64(buyer_signature)}|#{Base.url_encode64(seller_signature)}"
    payload = "#{ts}|#{txn_id}|#{txn_hash}|#{Base.url_encode64(buyer_signature)}|#{Base.url_encode64(seller_signature)}"
    {:ok, payload}
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
