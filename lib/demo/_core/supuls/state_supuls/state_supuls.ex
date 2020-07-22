defmodule Demo.StateSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls
  # alias Demo.Supuls.Supul
  # alias Demo.Supuls
  alias Demo.Openhashes.Openhash
  alias Demo.Openhashes
 
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
    Openhashes.make_state_openhash(state_supul)

    if state_supul.hash_count == 2, do: report_openhash_box_to_upper_supul(state_supul)
  end

  defp make_hash(state_supul, %{incoming_hash: incoming_hash, sender: supul_id}) do
    StateSupul.changeset(state_supul, %{incoming_hash: incoming_hash, sender: state_supul.id}) 
    |> Repo.update!
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
    StateSupul.changeset(state_supul, %{})
  end
end
