defmodule Demo.StateSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls
  # alias Demo.Supuls.Supul
  # alias Demo.Supuls
  alias Demo.Supuls.Openhash
 
  def list_state_supuls do
    Repo.all(StateSupul)
  end


  def get_state_supul!(id), do: Repo.get!(StateSupul, id)
 

  def create_state_supul(attrs) do
    StateSupul.changeset(attrs)
    |> Repo.insert() 
  end 
 
 
  def update_state_supul(%StateSupul{} = state_supul, %{
    incoming_hash: incoming_hash, sender: supul_id}) do
    make_hash(state_supul, %{incoming_hash: incoming_hash, sender: supul_id})
    make_openhash(state_supul)

    if state_supul.hash_count == 2, do: report_openhash_box_to_upper_supul(state_supul)
  end

  defp make_hash(state_supul, %{incoming_hash: incoming_hash, sender: supul_id}) do
    StateSupul.changeset(state_supul, %{incoming_hash: incoming_hash, sender: state_supul.id}) 
    |> Repo.update!
  end


  defp make_openhash(state_supul) do
    IO.puts "Make an openhash struct of the state supul"

    {:ok, openhash} = Openhash.changeset(%Openhash{}, %{
      supul_id: state_supul.id, 
      sender: state_supul.sender,
      incoming_hash: state_supul.incoming_hash,
      previous_hash: state_supul.previous_hash,
      current_hash: state_supul.current_hash,
      }) |> Repo.insert()

'''
    #? add supul signature to the openhash struct.  
    #? hard coding supul private key. 
    state_supul_priv_key = ExPublicKey.load!("./keys/jejudo_private_key.pem")
    
    openhash_serialized = Poison.encode!(openhash)
    openhash_hash = Pbkdf2.hash_pwd_salt(openhash_serialized)
    {:ok, supul_signature} = ExPublicKey.sign(openhash_hash, state_supul_priv_key)

    {:ok, openhash} = Openhash.changeset(openhash, %{supul_signature: supul_signature}) 
    |> Repo.update()
'''
    #? put assoc
    StateSupul.changeset_openhash(state_supul, %{openhash: openhash}) 
    |> Repo.update!

    #? UPDATE OPENHASH BOX
    #? add openhash_id to the openhash block of the supul.
    openhash_box = [openhash.id | state_supul.openhash_box]
    StateSupul.changeset(state_supul, %{openhash_box: openhash_box}) |> Repo.update()       
  end

  defp report_openhash_box_to_upper_supul(state_supul) do
    openhash_box_serialized = Poison.encode!(state_supul.openhash_box)
    hash_of_openhash_box = Pbkdf2.hash_pwd_salt(openhash_box_serialized)

    nation_supul = Repo.preload(state_supul, :nation_supul).nation_supul

    NationSupuls.update_nation_supul(nation_supul, %{
      incoming_hash: hash_of_openhash_box, sender: state_supul.id})
   
   #? init supul for the next hash block. 
    StateSupul.changeset(state_supul, %{
      hash_count: 1, openhash_box: []})
  end


  # end

  def update_state_supul(state_supul, attrs) do
    StateSupul.changeset(state_supul, attrs) |> Repo.update()
  end

  def change_state_supul(%StateSupul{} = state_supul) do
    # IO.inspect "change_state_supul"
    StateSupul.changeset(state_supul, %{})
  end
end
