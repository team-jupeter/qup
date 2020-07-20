defmodule Demo.Groups do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Groups.Group

  def list_groups do
    Repo.all(Group)
  end


  def get_group!(id), do: Repo.get!(Group, id)


  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end
end
