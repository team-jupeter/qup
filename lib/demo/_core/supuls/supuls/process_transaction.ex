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

  def process_transaction(transaction) do

    IO.puts "process_transaction"
    IO.inspect transaction

    case transaction.erl_type do
      "default" -> update_erl_AB(transaction)
      "private" -> update_erl_private_IS(transaction)
      "public" -> update_erl_public_IS(transaction)
    end

    case transaction.ssu_type do
      "default" -> update_ssu_AB(transaction)
      "private" -> update_ssu_private_IS(transaction)
      "public" -> update_ssu_public_IS(transaction)
    end

    update_gab_balance(transaction)
    update_t1s(transaction)

    {:ok, transaction}
  end


  defp update_erl_AB(transaction) do
    IO.puts "update_AB"

    # ? trader can be either erl or erl
    # ? Update AB or IS of erl's or erl's entity
    erl_ab =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.erl_id, select: a)

    # ? update AB or IS of erl's or erl's family, supul, state_supul, and nation_supul.
    AccountBooks.add_expense(erl_ab, %{amount: transaction.abc_amount}) 

    erl_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.erl_family_id 
      )
    IO.puts "erl_family_AB"
    AccountBooks.add_expense(erl_family_AB, %{amount: transaction.abc_amount}) |> IO.inspect


    erl_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.erl_supul_id
      )
    IO.puts "erl_supul_AB"
    AccountBooks.add_expense(erl_supul_AB, %{amount: transaction.abc_amount}) |> IO.inspect

    erl_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.erl_state_supul_id
      )
    AccountBooks.add_expense(erl_state_supul_AB, %{amount: transaction.abc_amount})

    erl_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )
    AccountBooks.add_expense(erl_nation_supul_AB, %{amount: transaction.abc_amount})
  end

  defp update_ssu_AB(transaction) do
    # ? trader can be either ssu or ssu
    # ? Update AB or IS of ssu's or ssu's entity
    ssu_ab =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.ssu_id, select: a)

    # ? update AB or IS of ssu's or ssu's family, supul, state_supul, and nation_supul.
    AccountBooks.add_revenue(ssu_ab, %{amount: transaction.abc_amount})

    ssu_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.ssu_family_id
      )
    AccountBooks.add_revenue(ssu_family_AB, %{amount: transaction.abc_amount})

    ssu_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.ssu_supul_id
      )
    AccountBooks.add_revenue(ssu_supul_AB, %{amount: transaction.abc_amount})

    ssu_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.ssu_state_supul_id
      )
    AccountBooks.add_revenue(ssu_state_supul_AB, %{amount: transaction.abc_amount})

    ssu_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )
    AccountBooks.add_revenue(ssu_nation_supul_AB, %{amount: transaction.abc_amount})
  end

  defp update_erl_private_IS(transaction) do
    # ? Update IS of buyer's, buyer's family, supul, state_supul, and nation_supul.
    erl_is =
      Repo.one(from a in IncomeStatement, 
      where: a.entity_id == ^transaction.erl_id, select: a)

    IncomeStatements.add_expense(erl_is, %{amount: transaction.abc_amount})

    erl_group_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.group_id == ^transaction.erl_group_id, select: a
      )

    IncomeStatements.add_expense(erl_group_is, %{amount: transaction.abc_amount})

    erl_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.erl_supul_id
      )

    IncomeStatements.add_expense(erl_supul_is, %{amount: transaction.abc_amount})

    erl_state_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.erl_state_supul_id
      )

    IncomeStatements.add_expense(erl_state_supul_is, %{amount: transaction.abc_amount})

    erl_nation_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )

    IncomeStatements.add_expense(erl_nation_supul_is, %{amount: transaction.abc_amount})
  end

  defp update_ssu_private_IS(transaction) do
    # ? Update IS of seller's, seller's family, supul, state_supul, and nation_supul.
    ssu_is =
      Repo.one(from a in IncomeStatement, 
      where: a.entity_id == ^transaction.ssu_id, select: a)

    IncomeStatements.add_revenue(ssu_is, %{amount: transaction.abc_amount})

    ssu_group_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.group_id == ^transaction.ssu_group_id, select: a
      )

    IncomeStatements.add_revenue(ssu_group_is, %{amount: transaction.abc_amount})

    ssu_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.ssu_supul_id
      )

    IncomeStatements.add_revenue(ssu_supul_is, %{amount: transaction.abc_amount})

    ssu_state_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.ssu_state_supul_id
      )

    IncomeStatements.add_revenue(ssu_state_supul_is, %{amount: transaction.abc_amount})

    ssu_nation_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )

    IncomeStatements.add_revenue(ssu_nation_supul_is, %{amount: transaction.abc_amount})
  end



  defp update_erl_public_IS(transaction) do
    # ? trader can be either erl or erl
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    erl_IS =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.erl_id, select: a)

    IncomeStatements.add_expense(erl_IS, %{amount: transaction.abc_amount})

    erl_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )

    IncomeStatements.add_expense(erl_nation_supul_IS, %{amount: transaction.abc_amount})
  end

  

  defp update_ssu_public_IS(transaction) do
    # ? trader can be either erl or erl
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    ssu_IS =
      Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.ssu_id, select: a)

    IncomeStatements.add_revenue(ssu_IS, %{amount: transaction.abc_amount})

    ssu_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )

    IncomeStatements.add_revenue(ssu_nation_supul_IS, %{amount: transaction.abc_amount})
  end

  defp update_gab_balance(transaction) do
    # ? Update gab_balance of both erl and erl.
    # ? Buyer's gab_balance
    query =
      from b in Entity,
        where: b.id == ^transaction.erl_id

    erl = Repo.one(query)
    Entities.minus_gab_balance(erl, %{amount: transaction.abc_amount})

    # ? Seller's gab_balance
    query =
      from s in Entity,
        where: s.id == ^transaction.ssu_id

    erl = Repo.one(query)
    Entities.plus_gab_balance(erl, %{amount: transaction.abc_amount})
  end

  defp update_t1s(transaction) do
    query =
      from b in Entity,
        where: b.id == ^transaction.erl_id

    erl = Repo.one(query)

    query =
      from s in Entity,
        where: s.id == ^transaction.ssu_id

    ssu = Repo.one(query)

    # ? t1s of both
    BalanceSheets.renew_t1s(%{amount: transaction.abc_amount}, erl, ssu)
  end
end
