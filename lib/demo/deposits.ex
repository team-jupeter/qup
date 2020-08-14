defmodule Demo.Deposits do
  @moduledoc """
  The Deposits context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Deposits.Deposit
  alias Demo.GabAccounts
  alias Demo.Entities.Entity

  def list_deposits do
    Repo.all(Deposit)
  end

  def get_deposit!(id), do: Repo.get!(Deposit, id)

  def create_deposit(attrs \\ %{}) do
    #? exchange rate between input and output currencies.
    input_currency = String.to_atom(attrs.input_currency)
    output_currency = String.to_atom(attrs.output_currency)
    input_amount = attrs["input_amount"]

    fx_amount = fx(input_currency, output_currency, input_amount)
    output_amount = Decimal.mult(fx_amount, input_amount)

    attrs = Map.merge(%{output_amount: output_amount}, attrs)

    # sender = Repo.one(from g in Gab, where: g.id == ^attrs.input_id, select: g)
    input = Repo.one(from e in Entity, where: e.id == ^attrs.input_id, select: e)
    input_gab = Repo.preload(input, :gab).gab

    # ? Update t1_pool of the gab
    t1_pool = Repo.preload(input_gab, :t1_pool).t1_pool
    t1_pool = Map.update!(t1_pool, input_currency, &Decimal.sub(&1, attrs.amount))

    # ? update gab_account of input.
    gab_account = Repo.preload(input, :gab_account).gab_account
    GabAccounts.add_open_t1s(gab_account, %{open_t1: attrs})

    %Deposit{}
    |> Deposit.changeset(attrs)
    |> Repo.insert()
  end

  defp fx(input_currency, output_currency, input_amount) do
    #? return dummy
    input_amount
  end

  def update_deposit(%Deposit{} = deposit, attrs) do
    deposit
    |> Deposit.changeset(attrs)
    |> Repo.update()
  end

  def delete_deposit(%Deposit{} = deposit) do
    Repo.delete(deposit)
  end

  def change_deposit(%Deposit{} = deposit) do
    Deposit.changeset(deposit, %{})
  end

  # ? When new fiat amounts come to GABs from outside world.
end
