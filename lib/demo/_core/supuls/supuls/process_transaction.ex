defmodule Demo.Supuls.ProcessTransaction do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.IncomeStatements
  alias Demo.BalanceSheets
  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  alias Demo.Entities
  alias Demo.Entities.Entity
  alias Demo.AccountBooks
  alias Demo.AccountBooks.AccountBook

  def process_transaction(transaction, _openhash) do
    case transaction.buyer_type do
      "default" -> update_buyer_AB(transaction)
      "pirvate" -> update_buyer_private_IS(transaction)
      "public" -> update_buyer_public_IS(transaction)
    end

    case transaction.seller_type do
      "default" -> update_seller_AB(transaction)
      "pirvate" -> update_seller_private_IS(transaction)
      "public" -> update_seller_public_IS(transaction)
    end

    update_gab_balance(transaction)
    update_t1s(transaction)
  end

  defp update_buyer_AB(transaction) do
    # ? trader can be either buyer or seller
    # ? Update AB or IS of buyer's or seller's entity
    IO.inspect transaction

    buyer_ab =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.buyer_id, select: a)

    # ? update AB or IS of buyer's or seller's family, supul, state_supul, and nation_supul.
    AccountBooks.add_expense(buyer_ab, %{amount: transaction.abc_amount})

    buyer_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.buyer_family_id
      )

    AccountBooks.add_expense(buyer_family_AB, %{amount: transaction.abc_amount})

    buyer_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.buyer_supul_id
      )

    AccountBooks.add_expense(buyer_supul_AB, %{amount: transaction.abc_amount})

    buyer_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.buyer_state_supul_id
      )

    AccountBooks.add_expense(buyer_state_supul_AB, %{amount: transaction.abc_amount})

    buyer_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.buyer_nation_supul_id
      )

    AccountBooks.add_expense(buyer_nation_supul_AB, %{amount: transaction.abc_amount})
  end

  defp update_seller_AB(transaction) do
    # ? trader can be either seller or seller
    # ? Update AB or IS of seller's or seller's entity
    seller_ab =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.seller_id, select: a)

    # ? update AB or IS of seller's or seller's family, supul, state_supul, and nation_supul.
    AccountBooks.add_expense(seller_ab, %{amount: transaction.abc_amount})

    seller_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.seller_family_id
      )

    AccountBooks.add_expense(seller_family_AB, %{amount: transaction.abc_amount})

    seller_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.seller_supul_id
      )

    AccountBooks.add_expense(seller_supul_AB, %{amount: transaction.abc_amount})

    seller_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.seller_state_supul_id
      )

    AccountBooks.add_expense(seller_state_supul_AB, %{amount: transaction.abc_amount})

    seller_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.seller_nation_supul_id
      )

    AccountBooks.add_expense(seller_nation_supul_AB, %{amount: transaction.abc_amount})
  end

  defp update_buyer_private_IS(transaction) do
    # ? trader can be either buyer or seller
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    buyer_IS =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.buyer_id, select: a)

    IncomeStatements.add_expense(buyer_IS, %{amount: transaction.abc_amount})

    buyer_group_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.group_id == ^transaction.buyer_group_id
      )

    IncomeStatements.add_expense(buyer_group_IS, %{amount: transaction.abc_amount})

    buyer_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.buyer_supul_id
      )

    IncomeStatements.add_expense(buyer_supul_IS, %{amount: transaction.abc_amount})

    buyer_state_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.buyer_state_supul_id
      )

    IncomeStatements.add_expense(buyer_state_supul_IS, %{amount: transaction.abc_amount})

    buyer_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.buyer_nation_supul_id
      )

    IncomeStatements.add_expense(buyer_nation_supul_IS, %{amount: transaction.abc_amount})
  end

  defp update_buyer_public_IS(transaction) do
    # ? trader can be either buyer or seller
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    buyer_IS =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.buyer_id, select: a)

    IncomeStatements.add_expense(buyer_IS, %{amount: transaction.abc_amount})

    buyer_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.buyer_nation_supul_id
      )

    IncomeStatements.add_expense(buyer_nation_supul_IS, %{amount: transaction.abc_amount})
  end

  defp update_seller_private_IS(transaction) do
    # ? trader can be either buyer or seller
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    seller_IS =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.seller_id, select: a)

    IncomeStatements.add_expense(seller_IS, %{amount: transaction.abc_amount})

    seller_group_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.group_id == ^transaction.seller_group_id
      )

    IncomeStatements.add_expense(seller_group_IS, %{amount: transaction.abc_amount})

    seller_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.seller_supul_id
      )

    IncomeStatements.add_expense(seller_supul_IS, %{amount: transaction.abc_amount})

    seller_state_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.seller_state_supul_id
      )

    IncomeStatements.add_expense(seller_state_supul_IS, %{amount: transaction.abc_amount})

    seller_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.seller_nation_supul_id
      )

    IncomeStatements.add_expense(seller_nation_supul_IS, %{amount: transaction.abc_amount})
  end


  defp update_seller_public_IS(transaction) do
    # ? trader can be either buyer or seller
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    seller_IS =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.seller_id, select: a)

    IncomeStatements.add_expense(seller_IS, %{amount: transaction.abc_amount})

    seller_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.seller_nation_supul_id
      )

    IncomeStatements.add_expense(seller_nation_supul_IS, %{amount: transaction.abc_amount})
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
