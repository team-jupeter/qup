defmodule Demo.Nations do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Nations.Nation

  def list_nations do
    Repo.all(Nation)
  end


  def get_nation!(id), do: Repo.get!(Nation, id)

  def create_nation(attrs \\ %{}) do
    %Nation{}
    |> Nation.changeset(attrs)
    # |> Ecto.Changeset.put_assoc(:costitution, costitution)
    |> Repo.insert()
  end

  def update_nation(%Nation{} = nation, attrs) do
    nation
    |> Nation.changeset(attrs)
    |> Repo.update()
  end

  def delete_nation(%Nation{} = nation) do
    Repo.delete(nation)
  end


  def change_nation(%Nation{} = nation) do
    Nation.changeset(nation, %{})
  end
end
