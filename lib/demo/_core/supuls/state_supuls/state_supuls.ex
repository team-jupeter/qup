defmodule Demo.StateSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls

  def list_state_supuls do
    Repo.all(StateSupul)
  end


  def get_state_supul!(id), do: Repo.get!(StateSupul, id)
 

  def create_state_supul(attrs) do
    StateSupul.changeset(attrs)
    |> Repo.insert() 
  end 

 
  def update_state_supul(%StateSupul{} = state_supul, attrs) do
    IO.inspect "update_state_supul"
    state_supul
    |> StateSupul.changeset(attrs)
    |> Repo.update()
    |> IO.inspect

    if state_supul.hash_count == 2 do
      nation_supul = Repo.preload(state_supul, :nation_supul).nation_supul
      NationSupuls.update_nation_supul(nation_supul, %{incoming_hash: state_supul.current_hash})
      
      StateSupul.changeset(state_supul, %{incoming_hash: nation_supul.current_hash, hash_count: 1})
      |> Repo.update!
    end
  end


  def delete_state_supul(%StateSupul{} = state_supul) do
    Repo.delete(state_supul)
  end

  def change_state_supul(%StateSupul{} = state_supul) do
    # IO.inspect "change_state_supul"
    StateSupul.changeset(state_supul, %{})
  end
end
