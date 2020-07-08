defmodule Demo.StateSupuls do

  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.StateSupuls.StateSupul

  def list_state_supuls do
    Repo.all(StateSupul)
  end


  def get_state_supul!(id), do: Repo.get!(StateSupul, id)


  def create_state_supul(attrs \\ %{}) do
    StateSupul.changeset(attrs)
    |> Repo.insert()
  end


  def update_state_supul(%StateSupul{} = state_supul, attrs) do
    state_supul
    |> StateSupul.changeset(attrs)
    |> Repo.update()
  end


  def delete_state_supul(%StateSupul{} = state_supul) do
    Repo.delete(state_supul)
  end

  def change_state_supul(%StateSupul{} = state_supul) do
    StateSupul.changeset(state_supul, %{})
  end
end
