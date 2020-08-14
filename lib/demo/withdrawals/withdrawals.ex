defmodule Demo.Withdrawals do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Withdrawals.Withdrawal
  alias Demo.Entities.Entity
  alias Demo.GabAccounts


  def list_withdrawals do
    Repo.all(Withdrawal)
  end

  def get_withdrawal!(id), do: Repo.get!(Withdrawal, id)

  def create_withdrawal(attrs \\ %{}) do
    #? exchange rate between input and output currencies.
    input_currency = String.to_atom(attrs.input_currency)
    output_currency = String.to_atom(attrs.output_currency)
    input_amount = attrs["input_amount"]

    fx_amount = fx(input_currency, output_currency, input_amount)
    output_amount = Decimal.mult(fx_amount, input_amount)

    attrs = Map.merge(%{output_amount: output_amount}, attrs)

    # sender = Repo.one(from g in Gab, where: g.id == ^attrs.input_id, select: g)
    output = Repo.one(from e in Entity, where: e.id == ^attrs.output_id, select: e)
    output_gab = Repo.preload(output, :gab).gab

    # ? Update t1_pool of the gab
    t1_pool = Repo.preload(output_gab, :t1_pool).t1_pool
    t1_pool = Map.update!(t1_pool, input_currency, &Decimal.add(&1, attrs.amount))

    # ? update gab_account of output.
    gab_account = Repo.preload(output, :gab_account).gab_account
    GabAccounts.sub_open_t1s(gab_account, %{open_t1: attrs})

    %Withdrawal{}
    |> Withdrawal.changeset(attrs) 
    |> Repo.insert()
  end

  defp fx(input_currency, output_currency, input_amount) do
    #? return dummy
    input_amount
  end

  def update_withdrawal(%Withdrawal{} = withdrawal, attrs) do
    withdrawal
    |> Withdrawal.changeset(attrs)
    |> Repo.update()
  end

  def delete_withdrawal(%Withdrawal{} = withdrawal) do
    Repo.delete(withdrawal)
  end

  def change_withdrawal(%Withdrawal{} = withdrawal) do
    Withdrawal.changeset(withdrawal, %{})
  end
end
