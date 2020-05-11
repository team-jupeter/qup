defmodule Demo.Taxation do
  @moduledoc """
  The Taxes context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Taxations.Taxation

  def list_taxations do
    Repo.all(Taxation)
  end

  def get_taxation!(id), do: Repo.get!(Taxation, id)

  def create_taxation(attrs \\ %{}) do
    %Taxation{}
    |> Taxation.changeset(attrs)
    |> Repo.insert()
  end

  def update_taxation(%Taxation{} = taxation, attrs) do
    taxation
    |> Taxation.changeset(attrs)
    |> Repo.update()
  end

  def delete_taxation(%Taxation{} = taxation) do
    Repo.delete(taxation)
  end

  def change_taxation(%Taxation{} = taxation) do
    Taxation.changeset(taxation, %{})
  end
end
