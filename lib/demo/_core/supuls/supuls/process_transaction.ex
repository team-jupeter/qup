defmodule Demo.Supuls.ProcessTransaction do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.IncomeStatements
  alias Demo.BalanceSheets
  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  alias Demo.Entities
  alias Demo.Entities.Entity

  def process_transaction(transaction, openhash) do
    case transaction.buyer_family_id do
      nil -> update_IS(transaction)
      _ -> update_AB(transaction)
    end

    case transaction.seller_family_id do
      nil -> update_IS(transaction)
      _ -> update_AB(transaction)
    end

    update_gab_balance(transaction)
    update_t1s(transaction)
  end

  defp update_AB(transaction) do
    # ? trader can be either buyer or seller
    # ? Update AB of buyer, buyer's family, supul, state_supul, and nation_supul.
    trader_AB =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.buyer_id, select: a)

    if trader_AB == nil do
      trader_AB =
        Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.seller_id, select: a)
    end

    AccountBooks.add_expense(trader_AB, %{amount: transaction.abc_amount})

    trader_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.trader_family_id
      )

    AccountBooks.add_expense(trader_family_AB, %{amount: transaction.abc_amount})

    trader_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.trader_supul_id
      )

    AccountBooks.add_expense(trader_supul_AB, %{amount: transaction.abc_amount})

    trader_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.trader_state_supul_id
      )

    AccountBooks.add_expense(trader_state_supul_AB, %{amount: transaction.abc_amount})

    trader_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.trader_nation_supul_id
      )

    AccountBooks.add_expense(trader_nation_supul_AB, %{amount: transaction.abc_amount})
  end

  defp update_IS(transaction) do
    # ? trader can be either buyer or seller
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    trader_IS =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.buyer_id, select: a)

    if trader_IS == nil do
      trader_IS =
        Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.seller_id, select: a)
    end

    IncomeStatements.add_expense(trader_IS, %{amount: transaction.abc_amount})

    trader_group_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.group_id == ^transaction.trader_group_id
      )

    IncomeStatements.add_expense(trader_group_IS, %{amount: transaction.abc_amount})

    trader_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.trader_supul_id
      )

    IncomeStatements.add_expense(trader_supul_IS, %{amount: transaction.abc_amount})

    trader_state_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.trader_state_supul_id
      )

    IncomeStatements.add_expense(trader_state_supul_IS, %{amount: transaction.abc_amount})

    trader_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.trader_nation_supul_id
      )

    IncomeStatements.add_expense(trader_nation_supul_IS, %{amount: transaction.abc_amount})
  end

  defp update_gab_balance(transaction) do
    # ? Update gab_balance of both buyer and seller.
    # ? Buyer's gab_balance
    query =
      from b in Entity,
        where: b.id == ^transaction.abc_input_id

    buyer = Repo.one(query)
    Entities.minus_gab_balance(buyer, %{amount: transaction.abc_amount})

    # ? Seller's gab_balance
    query =
      from s in Entity,
        where: s.id == ^transaction.abc_output_id

    seller = Repo.one(query)
    Entities.plus_gab_balance(seller, %{amount: transaction.abc_amount})
  end

  defp update_t1s(transaction) do
    query =
      from b in Entity,
        where: b.id == ^transaction.abc_input_id

    buyer = Repo.one(query)

    query =
      from s in Entity,
        where: s.id == ^transaction.abc_output_id

    seller = Repo.one(query)

    # ? t1s of both
    BalanceSheets.renew_t1s(%{amount: transaction.abc_amount}, buyer, seller)
  end
end
