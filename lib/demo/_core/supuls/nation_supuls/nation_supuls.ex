defmodule Demo.NationSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.NationSupuls.NationSupul

  def list_nation_supuls do
    Repo.all(NationSupul)
  end


  def get_nation_supul!(id), do: Repo.get!(NationSupul, id)

  def create_nation_supul(attrs \\ %{}) do
    NationSupul.changeset(attrs)
    |> Repo.insert()
  end

  def update_nation_supul(%NationSupul{} = nation_supul, attrs) do
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
