defmodule Demo.Supuls.ProcessTransaction do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.IncomeStatements
  alias Demo.BalanceSheets
  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  alias Demo.Business
  alias Demo.Business.Entity

  def process_transaction(transaction) do
    update_IS(transaction)
    update_gab_balance(transaction)
    update_t1s(transaction)
  end

  defp update_IS(transaction) do
    # ? Update IS of buyer.
    buyer_id = transaction.abc_input_id

    query =
      from i in IncomeStatement,
        where: i.entity_id == ^buyer_id

    buyer_IS = Repo.one(query)
    IncomeStatements.add_expense(buyer_IS, %{amount: transaction.abc_amount})

    # ? Update IS of seller.
    seller_id = transaction.abc_output_id

    query =
      from i in IncomeStatement,
        where: i.entity_id == ^seller_id

    seller_IS = Repo.one(query)
    IncomeStatements.add_revenue(seller_IS, %{amount: transaction.abc_amount})
  end

  defp update_gab_balance(transaction) do
    # ? Update gab_balance of both buyer and seller.
    # ? Buyer's gab_balance
    query =
      from b in Entity,
        where: b.id == ^transaction.abc_input_id

    buyer = Repo.one(query)
    Business.minus_gab_balance(buyer, %{amount: transaction.abc_amount})

    # ? Seller's gab_balance
    query =
      from s in Entity,
        where: s.id == ^transaction.abc_output_id

    seller = Repo.one(query)
    Business.plus_gab_balance(seller, %{amount: transaction.abc_amount})
  end

  defp update_t1s(transaction) do
    query =
      from b in Entity,
        where: b.id == ^transaction.abc_input_id

    buyer = Repo.one(query)

    # ? Seller's gab_balance
    query =
      from s in Entity,
        where: s.id == ^transaction.abc_output_id

    seller = Repo.one(query)

    # ? t1s of both
    BalanceSheets.renew_t1s(%{amount: transaction.abc_amount}, buyer, seller)
  end
end
