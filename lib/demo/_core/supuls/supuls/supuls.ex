defmodule Demo.Supuls do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.Supul
  alias Demo.IncomeStatements
  alias Demo.BalanceSheets 
  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  alias Demo.Business
  alias Demo.Business.Entity
  alias Demo.StateSupuls
  alias Demo.Supuls.Openhash
  # alias Demo.NationSupuls.NationSupul
  alias Demo.Supuls.Openhash
  alias Demo.Transactions

  def list_supuls do
    Repo.all(Supul)
  end

  def get_supul!(id), do: Repo.get!(Supul, id)

  def create_supul(attrs) do
    Supul.changeset(attrs)
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
    buyer_supul = get_supul!(transaction.buyer_supul_id)
    seller_supul = get_supul!(transaction.seller_supul_id)

    parts = String.split(payload, "|")

    # ? reject the payload if the timestamp is newer than the arriving time to supul. 
    recv_ts = Enum.fetch!(parts, 0)
    recv_txn_id = Enum.fetch!(parts, 1)
    recv_txn_hash = Enum.fetch!(parts, 2)

    {:ok, recv_sig_buyer} = Enum.fetch!(parts, 3) |> Base.url_decode64()
    {:ok, recv_sig_seller} = Enum.fetch!(parts, 4) |> Base.url_decode64()


    #? Hard coded public keys. Those shall be obtained via public routes.
    hong_entity_rsa_pub_key = ExPublicKey.load!("./keys/hong_entity_public_key.pem")
    tomi_rsa_pub_key = ExPublicKey.load!("./keys/tomi_public_key.pem")

    IO.puts "Do you see me? 1 ^^*"

    {:ok, sig_valid_buyer} =
      ExPublicKey.verify("#{recv_ts}|#{recv_txn_id}|#{recv_txn_hash}", recv_sig_buyer, hong_entity_rsa_pub_key)

    {:ok, sig_valid_seller} =
      ExPublicKey.verify("#{recv_ts}|#{recv_txn_id}|#{recv_txn_hash}", recv_sig_seller, tomi_rsa_pub_key)
    

    cond do
      sig_valid_buyer && sig_valid_seller -> 
        make_txnhash(buyer_supul, transaction.buyer_id, recv_txn_hash, transaction.id)
        make_openhash(buyer_supul, transaction)

        if buyer_supul.id != seller_supul.id do
          IO.puts "buyer_supul.id != seller_supul.id"
          make_txnhash(seller_supul, transaction.seller_id, recv_txn_hash, transaction.id)
          make_openhash(seller_supul, transaction)
        end
      true -> "error" #? halt the process
    end
  end

  defp make_txnhash(supul, entity_id, recv_txn_hash, txn_id) do
    Supul.changeset_txnhash(supul, %{sender: entity_id, txn_id: txn_id, incoming_hash: recv_txn_hash}) 
    |> Repo.update!
  end


  defp make_openhash(supul, transaction) do
    IO.puts "Make an openhash struct"

    {:ok, openhash} = Openhash.changeset(%Openhash{}, %{
      txn_id: supul.txn_id,
      incoming_hash: supul.incoming_hash,
      supul_id: supul.id, 
      previous_hash: supul.previous_hash,
      current_hash: supul.current_hash,
      }) |> Repo.insert()

  '''
    #? add supul signature to the openhash struct.  
    #? hard coding supul private key. 
    supul_rsa_priv_key = ExPublicKey.load!("./keys/hankyung_private_key.pem")

    openhash_serialized = Poison.encode!(openhash)    
    {:ok, supul_signature} = ExPublicKey.sign(ts_openhash_serialized, supul_rsa_priv_key)
    
    # openhash_hash = Pbkdf2.hash_pwd_salt(openhash_serilized)

    {:ok, openhash} = Openhash.changeset(openhash, %{supul_signature: supul_signature}) 
    |> Repo.update()
'''
    #? put assoc
    Repo.preload(supul, :openhash) 
    |> IO.inspect
    |> Supul.changeset_openhash(%{openhash: openhash}) 
    |> Repo.update!
  

    #? UPDATE OPENHASH BLOCK
    #? add openhash_id to the openhash block of the supul.
    openhash_box = [openhash.id | supul.openhash_box]
    Supul.changeset(supul, %{openhash_box: openhash_box}) |> Repo.update()  

    #? add openhash field to the transaction received. 

    Transactions.update_transaction(transaction, %{openhash: openhash, supul_code: supul.supul_code})
    
    IO.puts "if supul.hash_count == 2"
    # if supul.hash_count == 6, do: report_openhash_box_to_upper_supul(supul)
    if supul.hash_count == 100 do
      IO.puts "report_openhash_box_to_upper_supul"

      openhash_box_serialized = Poison.encode!(supul.openhash_box)
      hash_of_openhash_box = Pbkdf2.hash_pwd_salt(openhash_box_serialized)

      state_supul = Repo.preload(supul, :state_supul).state_supul

      StateSupuls.update_state_supul(state_supul, %{
        incoming_hash: hash_of_openhash_box, sender: supul.id})
          
      #? init supul for the next hash block. 
      Supul.changeset(supul, %{
        hash_count: 1, openhash_box: []})
    end


    IO.puts "Do you see me? 2 ^^*"
  end


  def process_transaction(transaction) do
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
