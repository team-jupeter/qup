defmodule Demo.GlobalSupuls do
  @moduledoc """
  The GlobalSupuls context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.GlobalSupul


  def list_global_supuls do
    Repo.all(GlobalSupul)
  end


  def get_global_supul!(id), do: Repo.get!(GlobalSupul, id)


  def create_global_supul(attrs \\ %{}) do
    %GlobalSupul{}
    |> GlobalSupul.changeset(attrs)
    |> Repo.insert()
  end


  def update_global_supul(%GlobalSupul{} = global_supul, attrs) do
    global_supul
    |> GlobalSupul.changeset(attrs)
    |> Repo.update()
  end

 
  def delete_global_supul(%GlobalSupul{} = global_supul) do
    Repo.delete(global_supul)
  end

  def change_global_supul(%GlobalSupul{} = global_supul) do
    GlobalSupul.changeset(global_supul, %{})
  end
end
