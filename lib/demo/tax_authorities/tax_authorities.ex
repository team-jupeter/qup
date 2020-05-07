defmodule Demo.TaxAuthorities do
  @moduledoc """
  The Taxes context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Taxes.TaxAuthority

  def list_tax_authorities do
    Repo.all(TaxAuthority)
  end

  def get_tax_authority!(id), do: Repo.get!(TaxAuthority, id)

  def create_tax_authority(attrs \\ %{}) do
    %TaxAuthority{}
    |> TaxAuthority.changeset(attrs)
    |> Repo.insert()
  end

  def update_tax_authority(%TaxAuthority{} = tax_authority, attrs) do
    tax_authority
    |> TaxAuthority.changeset(attrs)
    |> Repo.update()
  end

  def delete_tax_authority(%TaxAuthority{} = tax_authority) do
    Repo.delete(tax_authority)
  end

  def change_tax_authority(%TaxAuthority{} = tax_authority) do
    TaxAuthority.changeset(tax_authority, %{})
  end
end
