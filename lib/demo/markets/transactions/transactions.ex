defmodule Demo.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.Supuls
  alias Demo.Transactions.Transaction
  alias Demo.Business.Entity

  def list_transactions(%Entity{} = entity) do
    Transaction
    |> entity_transactions_query(entity)
    |> Repo.all()
  end

  
  def get_entity_transaction!(entity, id) do
    Transaction
    |> entity_transactions_query(entity)
    |> Repo.get!(id)
  end
  defp entity_transactions_query(query, entity) do
    from(t in query, 
    where: t.buyer_id == ^entity.id or t.seller_id == ^entity.id)
  end
  
  def get_transaction!(id), do: Repo.get!(Transaction, id)




  # def get_buyer_transaction!(entity, id) do
  #   BuyerEmbed
  #   |> buyer_transactions_query(entity)
  #   |> Repo.get!(id)
  # end
  # defp buyer_transactions_query(query, %Entity{id: entity_id}) do
  #   from(b in query, where: b.main_id == ^entity_id)
  # end


  # def get_seller_transaction!(entity, id) do
  #   SellerEmbed
  #   |> seller_transactions_query(entity)
  #   |> Repo.get!(id)
  # end
  # defp seller_transactions_query(query, %Entity{id: entity_id}) do
  #   from(s in query, where: s.main_id == ^entity_id)
  # end


  def create_transaction(_entity, {:ok, invoice}, buyer_rsa_priv_key, sender_rsa_priv_key) do
    attrs = %{
      buyer: invoice.buyer.main_name,
      seller: invoice.seller.main_name,
      buyer_id: invoice.buyer.main_id,
      seller_id: invoice.seller.main_id,
      abc_input_id: invoice.buyer.main_id, #? in real transaction, it should be a public addresss of buyer.
      abc_input_name: invoice.buyer.main_name, 
      abc_output_id: invoice.seller.main_id,  #? in real transaction, it should be a public addresss of seller.
      abc_output_name: invoice.seller.main_name,  
      abc_amount: invoice.total,
      fiat_currency: invoice.fiat_currency
    }
 
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:invoice, invoice)
    |> Repo.insert()
    |> make_payload_and_send_to_supul(buyer_rsa_priv_key, sender_rsa_priv_key) #? if fail, the code below is not called.
  end 

  defp make_payload_and_send_to_supul({:ok, transaction}, buyer_rsa_priv_key, sender_rsa_priv_key) do
    msg_serialized = Poison.encode!(transaction)
    ts = DateTime.utc_now() |> DateTime.to_unix()
    ts_msg_serialized = "#{ts}|#{msg_serialized}"

    {:ok, buyer_signature} = ExPublicKey.sign(ts_msg_serialized, buyer_rsa_priv_key)
    {:ok, seller_signature} = ExPublicKey.sign(ts_msg_serialized, sender_rsa_priv_key)

    payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(buyer_signature)}|#{Base.url_encode64(seller_signature)}"
    
    #? check whether the payload is correct or not
    #? if the payload is correct, update financial reports of both parties by 
    #? returning {:ok, transaction} and calling the next code line.
    
    IO.puts "Hi, I am here...smile ^^*"

    transaction
    |> Supuls.check_archive_payload(payload) #? if pass the check, return transaction
    |> Supuls.process_transaction() #? executed only if the code above succeeds.
  end

  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end


  # def delete_transaction(%Transaction{} = transaction) do
  #   Repo.delete(transaction)
  # end

  def change_transaction(%Transaction{} = transaction) do
    Transaction.changeset(transaction, %{})
  end
end
