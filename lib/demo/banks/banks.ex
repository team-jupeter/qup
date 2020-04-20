defmodule Demo.Banks do
  @moduledoc """
  The Banks context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Banks.Bank

  def list_banks do
    Repo.all(Bank)
  end


  def get_bank!(id), do: Repo.get!(Bank, id)

  def change_bank(%Bank{} = bank) do
    Bank.changeset(bank, %{})
  end

  def create_bank(attrs \\ %{}) do
    %Bank{}
    |> Bank.changeset(attrs)
    |> Repo.insert()
  end

  def update_bank(%Bank{} = bank, attrs) do
    bank
    |> Bank.changeset(attrs)
    |> Repo.update()
  end

  # def delete_bank(%Bank{} = bank) do
  #   Repo.delete(bank)
  # end
end
