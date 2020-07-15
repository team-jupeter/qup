# defmodule Demo.Openhashes do
#     @moduledoc """
#     The Taxes context.
#     """
  
#     import Ecto.Query, warn: false
#     alias Demo.Repo
  
#     alias Demo.Openhashes.Openhash
  
#     def list_openhashes do
#       Repo.all(Openhash)
#     end
  
#     def get_openhash!(id), do: Repo.get!(Openhash, id)
  
#     def create_openhash(supul, attrs \\ %{priv_key: priv_key}) do

#       {:ok, openhash} = Openhash.changeset(%Openhash{}, %{
#         supul_id: supul.id, 
#         incoming_hash: supul.incoming_hash,
#         previous_hash: supul.previous_hash,
#         current_hash: supul.current_hash,
#         }) |> Repo.insert()
  
  
#       #? add supul signature to the openhash struct.  
#       #? hard coding supul private key. 
#       {:ok, supul_signature} = ExPublicKey.sign(recv_txn_hash, priv_key)
      
#       Openhash.changeset(openhash, %{supul_signature: supul_signature}) |> Repo.update()
  
#       #? put assoc
#       Supul.changeset_openhash(supul, %{openhash: openhash}) 
#       |> Repo.update!
    
  
#       #? UPDATE OPENHASH BLOCK
#       #? add openhash_id to the openhash block of the supul.
#       openhash_box = [openhash.id | supul.openhash_box]
#       Supul.changeset(supul, %{openhash_box: openhash_box}) | Repo.update()  
  
   
#       #? add openhash field to the transaction received. 
#       Transactions.update_transaction(transaction, %{
#         openhash_id: openhash.id, supul_code: supul.supul_code})
     
#         %Openhash{}
#         |> Openhash.changeset(attrs)
#         |> Repo.insert()
#     end
  
#     def update_openhash(%Openhash{} = openhash, attrs) do
#       openhash
#       |> Openhash.changeset(attrs)
#       |> Repo.update()
#     end
  
#     def delete_openhash(%Openhash{} = openhash) do
#       Repo.delete(openhash)
#     end
  
#     def change_openhash(%Openhash{} = openhash) do
#       Openhash.changeset(openhash, %{})
#     end
#   end
  