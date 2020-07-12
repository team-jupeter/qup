defmodule Demo.NationSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.NationSupuls.NationSupul
  alias Demo.GlobalSupuls

  def list_nation_supuls do
    Repo.all(NationSupul)
  end
 

  def get_nation_supul!(id), do: Repo.get!(NationSupul, id)

  def create_nation_supul(attrs) do
    NationSupul.changeset(attrs)
    |> Repo.insert()
  end

  def update_nation_supul(%NationSupul{} = nation_supul, attrs) do
    IO.inspect "update_nation_supul"
    
    if nation_supul.hash_count == 5 do
      global_supul = Repo.preload(nation_supul, :global_supul).global_supul
      GlobalSupuls.update_global_supul(global_supul, %{incoming_hash: nation_supul.current_hash})
      
      NationSupul.changeset(nation_supul, %{incoming_hash: global_supul.current_hash, hash_count: 1})
      |> Repo.update!
    end

    nation_supul
    |> NationSupul.changeset(attrs)
    |> Repo.update()

  end

  def delete_nation_supul(%NationSupul{} = nation_supul) do
    Repo.delete(nation_supul)
  end

  def change_nation_supul(%NationSupul{} = nation_supul) do
    NationSupul.changeset(nation_supul, %{})
  end
end
