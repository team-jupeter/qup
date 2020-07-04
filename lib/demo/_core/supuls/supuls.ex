defmodule Demo.Supuls do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.Supul
  alias Demo.Mulets
  alias Demo.Mulets.Payload
  alias Demo.IncomeStatements
  alias Demo.BalanceSheets
  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  alias Demo.Business
  alias Demo.Business.Entity

  def list_supuls do
    Repo.all(Supul)
  end

  def get_supul!(id), do: Repo.get!(Supul, id)

  def create_supul(attrs \\ %{}) do
    %Supul{}
    |> Supul.changeset(attrs)
    |> Repo.insert()
  end

  def update_supul(%Supul{} = supul, attrs) do
    supul
    |> Supul.changeset(attrs)
    |> Repo.update()
  end

  def delete_supul(%Supul{} = supul) do
    Repo.delete(supul)
  end


  def change_supul(%Supul{} = supul) do
    Supul.changeset(supul, %{})
  end

  def check_archive_payload(transaction, payload) do

    parts = String.split(payload, "|")

    # ? reject the payload if the timestamp is newer than the arriving time to supul. 
    recv_ts = Enum.fetch!(parts, 0)

    #? verify the signature
    recv_msg_serialized = Enum.fetch!(parts, 1)
    {:ok, recv_sig_buyer} = Enum.fetch!(parts, 2) |> Base.url_decode64()
    {:ok, recv_sig_seller} = Enum.fetch!(parts, 3) |> Base.url_decode64()


    #? Hard coded public keys
    hong_entity_rsa_pub_key = ExPublicKey.load!("./keys/hong_entity_public_key.pem")
    tomi_rsa_pub_key = ExPublicKey.load!("./keys/tomi_public_key.pem")


    {:ok, sig_valid_buyer} =
      ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_buyer, hong_entity_rsa_pub_key)

    {:ok, sig_valid_seller} =
      ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_seller, tomi_rsa_pub_key)
    
    cond do
      sig_valid_buyer && sig_valid_seller -> archive_payload(transaction, payload)
      true -> "error" #? halt the process
    end
  end

  alias Demo.Mulets.Payload
  alias Demo.Mulets
  defp archive_payload(transaction, payload) do
    IO.inspect transaction

    IO.puts "smile again 2  ^^*"
    #? Archieve Payload
    {:ok, archived_payload} = Mulets.create_payload_archive(%{payload: payload}) 
    # {:ok, archived_payload} = Demo.Mulets.create_payload_archive(%{payload: payload}) 
    
    IO.puts "smile again 3 ^^*"
    IO.inspect archived_payload.payload_hash

    #? Openhash 
    openhash = Mulets.openhash(%{payload_hash: archived_payload.payload_hash})
    openhash = Demo.Mulets.openhash(%{payload_hash: archived_payload.payload_hash})


    #? Send archived_payload.payload_hash to buyer and seller for them to store it.
    #? The payload_hash should be signed by the private key of the supul.
    #? insert code below
    
    






    #? Return transaction to process_transaction() of Supuls.ex
    {:ok, transaction}
  end

  def process_transaction({:ok, transaction}) do
    update_IS(transaction)
    update_gab_balance(transaction)
    update_t1s(transaction)
  end

  defp update_IS(transaction) do
    #? Update IS of buyer.
    buyer_id = transaction.abc_input_id

    query = from i in IncomeStatement,
    where: i.entity_id == ^buyer_id
    
    buyer_IS = Repo.one(query)
    IncomeStatements.add_expense(buyer_IS, %{amount: transaction.abc_amount})
    
    #? Update IS of seller.
    seller_id = transaction.abc_output_id

    query = from i in IncomeStatement,
    where: i.entity_id == ^seller_id
    
    seller_IS = Repo.one(query)
    IncomeStatements.add_revenue(seller_IS, %{amount: transaction.abc_amount})
  end    

  defp update_gab_balance(transaction) do
    #? Update gab_balance of both buyer and seller.
    #? Buyer's gab_balance
    query = from b in Entity,
    where: b.id == ^transaction.abc_input_id

    buyer = Repo.one(query)
    Business.minus_gab_balance(buyer, %{amount: transaction.abc_amount}) 
    
    #? Seller's gab_balance
    query = from s in Entity,
    where: s.id == ^transaction.abc_output_id

    seller = Repo.one(query)
    Business.plus_gab_balance(seller, %{amount: transaction.abc_amount}) 
  end

  defp update_t1s(transaction) do
    query = from b in Entity,
    where: b.id == ^transaction.abc_input_id

    buyer = Repo.one(query)
    
    #? Seller's gab_balance
    query = from s in Entity,
    where: s.id == ^transaction.abc_output_id

    seller = Repo.one(query)

    #? t1s of both
    BalanceSheets.renew_t1s(%{amount: transaction.abc_amount}, buyer, seller)  
  end
end
