defmodule Demo.Supuls.ProcessTransaction do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.IncomeStatements
  alias Demo.BalanceSheets
  alias Demo.IncomeStatements
  alias Demo.Reports.IncomeStatement
  alias Demo.Reports.BalanceSheet
  # alias Demo.Entities
  alias Demo.Entities.Entity
  alias Demo.AccountBooks
  alias Demo.AccountBooks.AccountBook
  # alias Demo.GabAccounts

  alias Demo.Groups
  alias Demo.Families
  alias Demo.Supuls
  alias Demo.StateSupuls
  alias Demo.NationSupuls
  # alias Demo.GlobalSupuls
  alias Demo.Groups.Group
  alias Demo.Families.Family
  alias Demo.Supuls.Supul
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls.NationSupul
  # alias Demo.GlobalSupuls.GlobalSupul
  alias Demo.GabAccounts

  def process_transaction(transaction, openhash) do
    # update_GA(transaction)

    case transaction.erl_type do
      "default" ->
        update_erl_AB(transaction)
        update_erl_BS(transaction)

      "private" ->
        update_erl_private_IS(transaction)
        update_erl_private_BS(transaction)

      "public" ->
        update_erl_public_IS(transaction)
        update_erl_public_BS(transaction)
    end

    case transaction.ssu_type do
      "default" ->
        update_ssu_AB(transaction)
        update_ssu_BS(transaction)

      "private" ->
        update_ssu_private_IS(transaction)
        update_ssu_private_BS(transaction)

      "public" ->
        update_ssu_public_IS(transaction)
        update_ssu_public_BS(transaction)
    end

    update_t1_balance(transaction) 
    update_t1s(transaction, openhash)

    {:ok, transaction}
  end


  defp update_erl_AB(transaction) do
    IO.puts("update_AB")

    # ? trader can be either erl or erl
    # ? Update AB or IS of erl's or erl's entity
    erl_ab = Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.erl_id, select: a)

    # ? update AB or IS of erl's or erl's family, supul, state_supul, and nation_supul.
    AccountBooks.add_expense(erl_ab, %{amount: transaction.t1_amount})

    erl_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.erl_family_id
      )

    IO.puts("erl_family_AB")
    AccountBooks.add_expense(erl_family_AB, %{amount: transaction.t1_amount})

    erl_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.erl_supul_id
      )

    IO.puts("erl_supul_AB")
    AccountBooks.add_expense(erl_supul_AB, %{amount: transaction.t1_amount})

    erl_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.erl_state_supul_id
      )

    AccountBooks.add_expense(erl_state_supul_AB, %{amount: transaction.t1_amount})

    erl_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )

    AccountBooks.add_expense(erl_nation_supul_AB, %{amount: transaction.t1_amount})
  end

  defp update_erl_BS(transaction) do
    IO.puts("update_erl_BS")

    # ? trader can be either erl or erl
    # ? Update BS of erl's or erl's entity
    erl_bs =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.erl_id, select: a)

    # ? update BS or IS of erl's or erl's family, supul, state_supul, and nation_supul.
    BalanceSheets.minus_t1_balance(erl_bs, %{amount: transaction.t1_amount})

    IO.puts("erl_family_BS")
    erl_family_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.family_id == ^transaction.erl_family_id
      )


    BalanceSheets.minus_t1_balance(erl_family_BS, %{amount: transaction.t1_amount})


    IO.puts("erl_supul_BS")
    erl_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.supul_id == ^transaction.erl_supul_id
      )

    # IO.puts("erl_supul")

    # erl_supul =
    #   Repo.one(
    #     from a in Supul,
    #       where: a.id == ^transaction.erl_supul_id
    #   )

    BalanceSheets.minus_t1_balance(erl_supul_BS, %{amount: transaction.t1_amount})

    erl_state_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.state_supul_id == ^transaction.erl_state_supul_id
      )

    IO.puts("erl_state_supul_BS")

    BalanceSheets.minus_t1_balance(erl_state_supul_BS, %{amount: transaction.t1_amount})

    erl_nation_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )

    IO.puts("erl_nation_supul_BS")
    BalanceSheets.minus_t1_balance(erl_nation_supul_BS, %{amount: transaction.t1_amount})
  end

  defp update_ssu_AB(transaction) do
    # ? trader can be either ssu or ssu
    # ? Update AB or IS of ssu's or ssu's entity
    ssu_ab = Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.ssu_id, select: a)

    # ? update AB or IS of ssu's or ssu's family, supul, state_supul, and nation_supul.
    AccountBooks.add_revenue(ssu_ab, %{amount: transaction.t1_amount})

    ssu_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.ssu_family_id
      )

    AccountBooks.add_revenue(ssu_family_AB, %{amount: transaction.t1_amount})

    ssu_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.ssu_supul_id
      )

    AccountBooks.add_revenue(ssu_supul_AB, %{amount: transaction.t1_amount})

    ssu_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.ssu_state_supul_id
      )

    AccountBooks.add_revenue(ssu_state_supul_AB, %{amount: transaction.t1_amount})

    ssu_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )

    AccountBooks.add_revenue(ssu_nation_supul_AB, %{amount: transaction.t1_amount})
  end

  defp update_ssu_BS(transaction) do
    # ? trader can be either ssu or ssu
    # ? Update BS or IS of ssu's or ssu's entity
    ssu_ab =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.ssu_id, select: a)

    # ? update BS or IS of ssu's or ssu's family, supul, state_supul, and nation_supul.
    BalanceSheets.plus_t1_balance(ssu_ab, %{amount: transaction.t1_amount})

    ssu_family_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.family_id == ^transaction.ssu_family_id
      )

    BalanceSheets.plus_t1_balance(ssu_family_BS, %{amount: transaction.t1_amount})

    ssu_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.supul_id == ^transaction.ssu_supul_id
      )

    BalanceSheets.plus_t1_balance(ssu_supul_BS, %{amount: transaction.t1_amount})

    ssu_state_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.state_supul_id == ^transaction.ssu_state_supul_id
      )

    BalanceSheets.plus_t1_balance(ssu_state_supul_BS, %{amount: transaction.t1_amount})

    ssu_nation_supul_BS =
      Repo.one(
        from a in BalanceSheet, 
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )

    BalanceSheets.plus_t1_balance(ssu_nation_supul_BS, %{amount: transaction.t1_amount})
  end

  defp update_erl_private_IS(transaction) do
    # ? Update IS of buyer's, buyer's family, supul, state_supul, and nation_supul.
    erl_is =
      Repo.one(from a in IncomeStatement, where: a.entity_id == ^transaction.erl_id, select: a)

    IncomeStatements.add_expense(erl_is, %{amount: transaction.t1_amount})

    erl_group_is =
      Repo.one(
        from a in IncomeStatement, where: a.group_id == ^transaction.erl_group_id, select: a
      )

    IncomeStatements.add_expense(erl_group_is, %{amount: transaction.t1_amount})

    erl_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.erl_supul_id
      )

    IncomeStatements.add_expense(erl_supul_is, %{amount: transaction.t1_amount})

    erl_state_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.erl_state_supul_id
      )

    IncomeStatements.add_expense(erl_state_supul_is, %{amount: transaction.t1_amount})

    erl_nation_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )

    IncomeStatements.add_expense(erl_nation_supul_is, %{amount: transaction.t1_amount})
  end

  defp update_erl_private_BS(transaction) do
    # ? Update BS of buyer's, buyer's family, supul, state_supul, and nation_supul.
    erl_bs =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.erl_id, select: a)

    BalanceSheets.minus_t1_balance(erl_bs, %{amount: transaction.t1_amount})

    erl_group_bs =
      Repo.one(from a in BalanceSheet, where: a.group_id == ^transaction.erl_group_id, select: a)

    BalanceSheets.minus_t1_balance(erl_group_bs, %{amount: transaction.t1_amount})

    erl_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.supul_id == ^transaction.erl_supul_id
      )

    BalanceSheets.minus_t1_balance(erl_supul_bs, %{amount: transaction.t1_amount})

    erl_state_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.state_supul_id == ^transaction.erl_state_supul_id
      )

    BalanceSheets.minus_t1_balance(erl_state_supul_bs, %{amount: transaction.t1_amount})

    erl_nation_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )

    BalanceSheets.minus_t1_balance(erl_nation_supul_bs, %{amount: transaction.t1_amount})
  end

  defp update_ssu_private_IS(transaction) do
    # ? Update IS of seller's, seller's family, supul, state_supul, and nation_supul.
    ssu_is =
      Repo.one(from a in IncomeStatement, where: a.entity_id == ^transaction.ssu_id, select: a)

    IncomeStatements.add_revenue(ssu_is, %{amount: transaction.t1_amount})

    ssu_group_is =
      Repo.one(
        from a in IncomeStatement, where: a.group_id == ^transaction.ssu_group_id, select: a
      )

    IncomeStatements.add_revenue(ssu_group_is, %{amount: transaction.t1_amount})

    ssu_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.ssu_supul_id
      )

    IncomeStatements.add_revenue(ssu_supul_is, %{amount: transaction.t1_amount})

    ssu_state_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.ssu_state_supul_id
      )

    IncomeStatements.add_revenue(ssu_state_supul_is, %{amount: transaction.t1_amount})

    ssu_nation_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )

    IncomeStatements.add_revenue(ssu_nation_supul_is, %{amount: transaction.t1_amount})
  end

  defp update_ssu_private_BS(transaction) do
    # ? Update BS of seller's, seller's family, supul, state_supul, and nation_supul.
    ssu_bs =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.ssu_id, select: a)

    BalanceSheets.plus_t1_balance(ssu_bs, %{amount: transaction.t1_amount})

    ssu_group_bs =
      Repo.one(from a in BalanceSheet, where: a.group_id == ^transaction.ssu_group_id, select: a)

    BalanceSheets.plus_t1_balance(ssu_group_bs, %{amount: transaction.t1_amount})

    ssu_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.supul_id == ^transaction.ssu_supul_id
      )

    BalanceSheets.plus_t1_balance(ssu_supul_bs, %{amount: transaction.t1_amount})

    ssu_state_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.state_supul_id == ^transaction.ssu_state_supul_id
      )

    BalanceSheets.plus_t1_balance(ssu_state_supul_bs, %{amount: transaction.t1_amount})

    ssu_nation_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )

    BalanceSheets.plus_t1_balance(ssu_nation_supul_bs, %{amount: transaction.t1_amount})
  end

  defp update_erl_public_IS(transaction) do
    # ? trader can be either erl or erl
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    erl_IS =
      Repo.one(from a in IncomeStatement, where: a.entity_id == ^transaction.erl_id, select: a)

    IncomeStatements.add_expense(erl_IS, %{amount: transaction.t1_amount})

    erl_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )

    IncomeStatements.add_expense(erl_nation_supul_IS, %{amount: transaction.t1_amount})
  end

  defp update_erl_public_BS(transaction) do
    # ? trader can be either erl or erl
    # ? Update BS of trader, trader's family, supul, state_supul, and nation_supul.
    erl_BS =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.erl_id, select: a)

    BalanceSheets.minus_t1_balance(erl_BS, %{amount: transaction.t1_amount})

    erl_nation_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.erl_nation_supul_id
      )

    BalanceSheets.minus_t1_balance(erl_nation_supul_BS, %{amount: transaction.t1_amount})
  end

  defp update_ssu_public_IS(transaction) do
    # ? trader can be either erl or erl
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    ssu_IS = Repo.one(from a in IncomeStatement, where: a.entity_id == ^transaction.ssu_id, select: a)

    IncomeStatements.add_revenue(ssu_IS, %{amount: transaction.t1_amount})

    ssu_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )

    IncomeStatements.add_revenue(ssu_nation_supul_IS, %{amount: transaction.t1_amount})
  end

  defp update_ssu_public_BS(transaction) do
    # ? trader can be either ssu or ssu
    # ? Update BS of trader, trader's family, supul, state_supul, and nation_supul.
    ssu_BS =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.ssu_id, select: a)

    BalanceSheets.plus_t1_balance(ssu_BS, %{amount: transaction.t1_amount})

    ssu_nation_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.ssu_nation_supul_id
      )

    BalanceSheets.plus_t1_balance(ssu_nation_supul_BS, %{amount: transaction.t1_amount})
  end

  defp update_t1_balance(transaction) do
    # ? Update t1_balance of both erl and erl.
    # ? Buyer's t1_balance
    query =
      from b in Entity,
        where: b.id == ^transaction.erl_id

    erl = Repo.one(query)
    gab_account = Repo.preload(erl, :gab_account).gab_account
    GabAccounts.minus_t1_balance(gab_account, %{amount: transaction.t1_amount})
    
    case erl.type do
      "default" ->
        query = from f in Family, where: f.id == ^transaction.erl_family_id, select: f
        erl_family = Repo.one(query)
        Families.minus_t1_balance(erl_family, %{amount: transaction.t1_amount})

        query = from s in Supul, where: s.id == ^transaction.erl_supul_id, select: s
        erl_supul = Repo.one(query)
        Supuls.minus_t1_balance(erl_supul, %{amount: transaction.t1_amount})

        query = from s in StateSupul, where: s.id == ^transaction.erl_state_supul_id, select: s
        erl_state_supul = Repo.one(query)
        StateSupuls.minus_t1_balance(erl_state_supul, %{amount: transaction.t1_amount})

        query = from s in NationSupul, where: s.id == ^transaction.erl_nation_supul_id, select: s
        erl_nation_supul = Repo.one(query)
        NationSupuls.minus_t1_balance(erl_nation_supul, %{amount: transaction.t1_amount})

      "private" ->
        query = from g in Group, where: g.id == ^transaction.erl_group_id, select: g
        erl_group = Repo.one(query)
        Groups.minus_t1_balance(erl_group, %{amount: transaction.t1_amount})

        query = from s in Supul, where: s.id == ^transaction.erl_supul_id, select: s
        erl_supul = Repo.one(query)
        Supuls.minus_t1_balance(erl_supul, %{amount: transaction.t1_amount})

        query = from s in StateSupul, where: s.id == ^transaction.erl_state_supul_id, select: s
        erl_state_supul = Repo.one(query)
        StateSupuls.minus_t1_balance(erl_state_supul, %{amount: transaction.t1_amount})

        query = from s in NationSupul, where: s.id == ^transaction.erl_nation_supul_id, select: s
        erl_nation_supul = Repo.one(query)
        NationSupuls.minus_t1_balance(erl_nation_supul, %{amount: transaction.t1_amount})

      "public" ->
        query = from s in NationSupul, where: s.id == ^transaction.erl_nation_supul_id, select: s
        erl_nation_supul = Repo.one(query)
        NationSupuls.minus_t1_balance(erl_nation_supul, %{amount: transaction.t1_amount})
    end

    # ? Seller's t1_balance
    query =
      from s in Entity,
        where: s.id == ^transaction.ssu_id

    ssu = Repo.one(query)
    gab_account = Repo.preload(ssu, :gab_account).gab_account
    GabAccounts.plus_t1_balance(gab_account, %{amount: transaction.t1_amount})

    case ssu.type do
      "default" ->
        query = from f in Family, where: f.id == ^transaction.ssu_family_id, select: f
        ssu_family = Repo.one(query)
        Families.plus_t1_balance(ssu_family, %{amount: transaction.t1_amount})

        query = from s in Supul, where: s.id == ^transaction.ssu_supul_id, select: s
        ssu_supul = Repo.one(query)
        Supuls.plus_t1_balance(ssu_supul, %{amount: transaction.t1_amount})

        query = from s in StateSupul, where: s.id == ^transaction.ssu_state_supul_id, select: s
        ssu_state_supul = Repo.one(query)
        StateSupuls.plus_t1_balance(ssu_state_supul, %{amount: transaction.t1_amount})

        query = from s in NationSupul, where: s.id == ^transaction.ssu_nation_supul_id, select: s
        ssu_nation_supul = Repo.one(query)
        NationSupuls.plus_t1_balance(ssu_nation_supul, %{amount: transaction.t1_amount})

      "private" ->
        query = from g in Group, where: g.id == ^transaction.ssu_group_id, select: g
        ssu_group = Repo.one(query)
        Groups.plus_t1_balance(ssu_group, %{amount: transaction.t1_amount})

        query = from s in Supul, where: s.id == ^transaction.ssu_supul_id, select: s
        ssu_supul = Repo.one(query)
        Supuls.plus_t1_balance(ssu_supul, %{amount: transaction.t1_amount})

        query = from s in StateSupul, where: s.id == ^transaction.ssu_state_supul_id, select: s
        ssu_state_supul = Repo.one(query)
        StateSupuls.plus_t1_balance(ssu_state_supul, %{amount: transaction.t1_amount})

        query = from s in NationSupul, where: s.id == ^transaction.ssu_nation_supul_id, select: s
        ssu_nation_supul = Repo.one(query)
        NationSupuls.plus_t1_balance(ssu_nation_supul, %{amount: transaction.t1_amount})

      "public" ->
        query = from s in NationSupul, where: s.id == ^transaction.ssu_nation_supul_id, select: s
        ssu_nation_supul = Repo.one(query)
        NationSupuls.plus_t1_balance(ssu_nation_supul, %{amount: transaction.t1_amount})
    end
  end

  defp update_t1s(transaction, openhash) do
    query =
      from b in Entity,
        where: b.id == ^transaction.erl_id

    erl = Repo.one(query)

    query =
      from s in Entity,
        where: s.id == ^transaction.ssu_id

    ssu = Repo.one(query)

    # ? ts of both
    IO.inspect "transaction.t1_amount"

    GabAccounts.renew_t1s(%{amount: transaction.t1_amount}, erl, ssu, openhash)
  end
end 
