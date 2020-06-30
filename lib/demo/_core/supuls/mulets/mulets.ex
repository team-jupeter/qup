defmodule Demo.Mulets do
  @moduledoc """
  The Mulets context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Mulets.Mulet

  def list_mulets do
    Repo.all(Mulet)
  end

  def get_mulet!(id), do: Repo.get!(Mulet, id)


  def create_mulet(attrs \\ %{}) do
    %Mulet{}
    |> Mulet.changeset(attrs)
    |> Repo.insert()
  end


  def update_mulet(%Mulet{} = mulet, attrs) do
    mulet
    |> Mulet.changeset(attrs)
    |> Repo.update()
  end


  def delete_mulet(%Mulet{} = mulet) do
    Repo.delete(mulet)
  end


  def change_mulet(%Mulet{} = mulet) do
    Mulet.changeset(mulet, %{})
  end
end
