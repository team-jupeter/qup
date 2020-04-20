defmodule Demo.Taxes do
  @moduledoc """
  The Taxes context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Taxes.Tax

  def list_taxes do
    Repo.all(Tax)
  end

  def get_tax!(id), do: Repo.get!(Tax, id)

  def create_tax(attrs \\ %{}) do
    %Tax{}
    |> Tax.changeset(attrs)
    |> Repo.insert()
  end

  def update_tax(%Tax{} = tax, attrs) do
    tax
    |> Tax.changeset(attrs)
    |> Repo.update()
  end

  def delete_tax(%Tax{} = tax) do
    Repo.delete(tax)
  end

  def change_tax(%Tax{} = tax) do
    Tax.changeset(tax, %{})
  end
end
