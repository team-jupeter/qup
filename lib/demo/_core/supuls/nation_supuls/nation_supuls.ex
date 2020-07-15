defmodule Demo.NationSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.NationSupuls.NationSupul
  alias Demo.GlobalSupuls
  alias Demo.NationSupuls
  alias Demo.StateSupuls
  alias Demo.Supuls.Supul
  alias Demo.Supuls.Openhash

  def list_nation_supuls do
    Repo.all(NationSupul)
  end
 

  def get_nation_supul!(id), do: Repo.get!(NationSupul, id)

  def create_nation_supul(attrs) do
    NationSupul.changeset(attrs)
    |> Repo.insert()
  end

  
  def update_nation_supul(%NationSupul{} = nation_supul, %{
    incoming_hash: incoming_hash, sender: state_supul_id}) do

    make_hash(nation_supul, %{incoming_hash: incoming_hash, sender: state_supul_id})
    make_openhash(nation_supul)

    if nation_supul.hash_count == 2, do: report_openhash_box_to_upper_supul(nation_supul)
  end

  defp make_hash(nation_supul, attrs) do
    Supul.changeset_txnhash(nation_supul, attrs) 
    |> Repo.update!
  end


  defp make_openhash(nation_supul) do
    IO.puts "Make an openhash struct of the nation supul"

    {:ok, openhash} = Openhash.changeset(%Openhash{}, %{
      supul_id: nation_supul.id, 
      sender: nation_supul.sender,
      incoming_hash: nation_supul.incoming_hash,
      previous_hash: nation_supul.previous_hash,
      current_hash: nation_supul.current_hash,
      }) |> Repo.insert()

'''
    #? add supul signature to the openhash struct.  
    #? hard coding supul private key. 
    nation_supul_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")

    openhash_serialized = Poison.encode!(openhash)
    openhash_hash = Pbkdf2.hash_pwd_salt(openhash_serialized)
    {:ok, supul_signature} = ExPublicKey.sign(openhash_hash, nation_supul_priv_key)
    
    {:ok, openhash} = Openhash.changeset(openhash, %{supul_signature: supul_signature}) |> Repo.update()
'''
    #? put assoc
    NationSupul.changeset_openhash(nation_supul, %{openhash: openhash}) 
    |> Repo.update!

    #? UPDATE OPENHASH BOX
    #? add openhash_id to the openhash block of the supul.
    openhash_box = [openhash.id | nation_supul.openhash_box]
    NationSupul.changeset(nation_supul, %{openhash_box: openhash_box}) |> Repo.update()       
  end

  defp report_openhash_box_to_upper_supul(nation_supul) do
    openhash_box_serialized = Poison.encode!(nation_supul.openhash_box)
    hash_of_openhash_box = Pbkdf2.hash_pwd_salt(openhash_box_serialized)

    global_supul = Repo.preload(nation_supul, :global_supul).global_supul

    GloabalSupuls.update_global_supul(global_supul, %{
      incoming_hash: hash_of_openhash_box, sender: nation_supul.id})
   
   #? init supul for the next hash block. 
    NationSupul.changeset(nation_supul, %{
      hash_count: 1, openhash_box: []})
  end



  def update_nation_supul(nation_supul, attrs) do
    NationSupul.changeset(nation_supul, attrs) |> Repo.update()
  end

  def delete_nation_supul(%NationSupul{} = nation_supul) do
    Repo.delete(nation_supul)
  end

  def change_nation_supul(%NationSupul{} = nation_supul) do
    NationSupul.changeset(nation_supul, %{})
  end
end
