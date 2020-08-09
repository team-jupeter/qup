defmodule Demo.Gabs do


  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Gabs.Gab


  def list_gabs do
    Repo.all(Gab)
  end


  def get_gab!(id), do: Repo.get!(Gab, id)


  def create_gab(attrs \\ %{}) do
    %Gab{}
    |> Gab.changeset(attrs)
    |> Repo.insert()
  end



  def update_gab(%Gab{} = gab, attrs) do
    gab
    |> Gab.changeset(attrs)
    |> Repo.update()
  end


  def delete_gab(%Gab{} = gab) do
    Repo.delete(gab)
  end


  def change_gab(%Gab{} = gab) do
    Gab.changeset(gab, %{})
  end


end
