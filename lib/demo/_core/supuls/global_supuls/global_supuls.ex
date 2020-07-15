defmodule Demo.GlobalSupuls do
  @moduledoc """
  The GlobalSupuls context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.GlobalSupuls.GlobalSupul
  # alias Demo.NationSupuls
  alias Demo.Supuls.Openhash


  def list_global_supuls do
    Repo.all(GlobalSupul)
  end


  def get_global_supul!(id), do: Repo.get!(GlobalSupul, id)


  def create_global_supul(attrs \\ %{}) do
    %GlobalSupul{}
    |> GlobalSupul.changeset(attrs)
    |> Repo.insert()
  end


  def update_global_supul(%GlobalSupul{} = global_supul, %{
    incoming_hash: incoming_hash, sender: nation_supul_id}) do

    make_hash(global_supul, %{incoming_hash: incoming_hash, sender: nation_supul_id})
    make_openhash(global_supul)

    # if global_supul.hash_count == 2, do: report_openhash_box_to_upper_supul(global_supul)
  end

  defp make_hash(global_supul, attrs) do
    GlobalSupul.changeset(global_supul, attrs) 
    |> Repo.update!
  end


  defp make_openhash(global_supul) do
    IO.puts "Make an openhash struct of the global supul"

    {:ok, openhash} = Openhash.changeset(%Openhash{}, %{
      supul_id: global_supul.id, 
      sender: global_supul.sender,
      incoming_hash: global_supul.incoming_hash,
      previous_hash: global_supul.previous_hash,
      current_hash: global_supul.current_hash,
      }) |> Repo.insert()


    #? add supul signature to the openhash struct.  
    #? hard coding supul private key. 
    global_supul_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")

    openhash_serialized = Poison.encode!(openhash)
    openhash_hash = Pbkdf2.hash_pwd_salt(openhash_serialized)
    {:ok, supul_signature} = ExPublicKey.sign(openhash_hash, global_supul_priv_key)
    
    {:ok, openhash} = Openhash.changeset(openhash, %{supul_signature: supul_signature}) |> Repo.update()

    #? put assoc
    GlobalSupul.changeset_openhash(global_supul, %{openhash: openhash}) 
    |> Repo.update!

    #? UPDATE OPENHASH BOX
    #? add openhash_id to the openhash block of the supul.
    openhash_box = [openhash.id | global_supul.openhash_box]
    GlobalSupul.changeset(global_supul, %{openhash_box: openhash_box}) |> Repo.update()       
  end

  # defp report_openhash_box_to_upper_supul(global_supul) do
  #   openhash_box_serialized = Poison.encode!(global_supul.openhash_box)
  #   hash_of_openhash_box = Pbkdf2.hash_pwd_salt(openhash_box_serialized)

  #   global_supul = Repo.preload(supul, :global_supul).global_supul

  #   GloabalSupuls.update_global_supul(global_supul, %{
  #     incoming_hash: hash_of_openhash_box, sender: global_supul.id})
   
  # #  #? init supul for the next hash block. 
  # #   GlobalSupul.changeset(global_supul, %{
  # #     hash_count: 1, openhash_box: []})
  # end


 
  def update_global_supul(global_supul, attrs) do
    GlobalSupul.changeset(global_supul, attrs) |> Repo.update()
  end
 
  def delete_global_supul(%GlobalSupul{} = global_supul) do
    Repo.delete(global_supul)
  end

  def change_global_supul(%GlobalSupul{} = global_supul) do
    GlobalSupul.changeset(global_supul, %{})
  end
end
