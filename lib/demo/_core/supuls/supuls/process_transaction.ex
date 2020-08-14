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
  alias Demo.Gabs

  def process_transaction(transaction, openhash) do
    # update_GA(transaction)

    case transaction.input_type do
      "default" ->
        update_input_AB(transaction)
        update_input_BS(transaction)

      "private" ->
        update_input_private_IS(transaction)
        update_input_private_BS(transaction)

      "public" ->
        update_input_public_IS(transaction)
        update_input_public_BS(transaction)
    end

    case transaction.output_type do
      "default" ->
        update_output_AB(transaction)
        update_output_BS(transaction)

      "private" ->
        update_output_private_IS(transaction)
        update_output_private_BS(transaction)

      "public" ->
        update_output_public_IS(transaction)
        update_output_public_BS(transaction)
    end

    update_t1_balance(transaction)
    update_t1s(transaction, openhash)

    {:ok, transaction}
  end

  defp update_input_AB(transaction) do
    IO.puts("update_AB")

    # ? trader can be either input or input
    # ? Update AB or IS of input's or input's entity
    input_ab = Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.input_id, select: a)

    # ? update AB or IS of input's or input's family, supul, state_supul, and nation_supul.
    AccountBooks.add_expense(input_ab, %{amount: transaction.t1_amount})

    input_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.input_family_id
      )

    IO.puts("input_family_AB")
    AccountBooks.add_expense(input_family_AB, %{amount: transaction.t1_amount})

    input_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.input_supul_id
      )

    IO.puts("input_supul_AB")
    AccountBooks.add_expense(input_supul_AB, %{amount: transaction.t1_amount})

    input_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.input_state_supul_id
      )

    AccountBooks.add_expense(input_state_supul_AB, %{amount: transaction.t1_amount})

    input_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.input_nation_supul_id
      )

    AccountBooks.add_expense(input_nation_supul_AB, %{amount: transaction.t1_amount})
  end

  defp update_input_BS(transaction) do
    IO.puts("update_input_BS")

    # ? trader can be either input or input
    # ? Update BS of input's or input's entity
    input_bs =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.input_id, select: a)

    # ? update BS or IS of input's or input's family, supul, state_supul, and nation_supul.
    BalanceSheets.minus_t1_balance(input_bs, %{amount: transaction.t1_amount})

    IO.puts("input_family_BS")

    input_family_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.family_id == ^transaction.input_family_id
      )

    BalanceSheets.minus_t1_balance(input_family_BS, %{amount: transaction.t1_amount})

    IO.puts("input_supul_BS")

    input_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.supul_id == ^transaction.input_supul_id
      )

    # IO.puts("input_supul")

    # input_supul =
    #   Repo.one(
    #     from a in Supul,
    #       where: a.id == ^transaction.input_supul_id
    #   )

    BalanceSheets.minus_t1_balance(input_supul_BS, %{amount: transaction.t1_amount})

    input_state_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.state_supul_id == ^transaction.input_state_supul_id
      )

    IO.puts("input_state_supul_BS")

    BalanceSheets.minus_t1_balance(input_state_supul_BS, %{amount: transaction.t1_amount})

    input_nation_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.input_nation_supul_id
      )

    IO.puts("input_nation_supul_BS")
    BalanceSheets.minus_t1_balance(input_nation_supul_BS, %{amount: transaction.t1_amount})
  end

  defp update_output_AB(transaction) do
    # ? trader can be either output or output
    # ? Update AB or IS of output's or output's entity
    output_ab = Repo.one(from a in AccountBook, where: a.entity_id == ^transaction.output_id, select: a)

    # ? update AB or IS of output's or output's family, supul, state_supul, and nation_supul.
    AccountBooks.add_revenue(output_ab, %{amount: transaction.t1_amount})

    output_family_AB =
      Repo.one(
        from a in AccountBook,
          where: a.family_id == ^transaction.output_family_id
      )

    AccountBooks.add_revenue(output_family_AB, %{amount: transaction.t1_amount})

    output_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.supul_id == ^transaction.output_supul_id
      )

    AccountBooks.add_revenue(output_supul_AB, %{amount: transaction.t1_amount})

    output_state_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.state_supul_id == ^transaction.output_state_supul_id
      )

    AccountBooks.add_revenue(output_state_supul_AB, %{amount: transaction.t1_amount})

    output_nation_supul_AB =
      Repo.one(
        from a in AccountBook,
          where: a.nation_supul_id == ^transaction.output_nation_supul_id
      )

    AccountBooks.add_revenue(output_nation_supul_AB, %{amount: transaction.t1_amount})
  end

  defp update_output_BS(transaction) do
    # ? trader can be either output or output
    # ? Update BS or IS of output's or output's entity
    output_ab =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.output_id, select: a)

    # ? update BS or IS of output's or output's family, supul, state_supul, and nation_supul.
    BalanceSheets.plus_t1_balance(output_ab, %{amount: transaction.t1_amount})

    output_family_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.family_id == ^transaction.output_family_id
      )

    BalanceSheets.plus_t1_balance(output_family_BS, %{amount: transaction.t1_amount})

    output_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.supul_id == ^transaction.output_supul_id
      )

    BalanceSheets.plus_t1_balance(output_supul_BS, %{amount: transaction.t1_amount})

    output_state_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.state_supul_id == ^transaction.output_state_supul_id
      )

    BalanceSheets.plus_t1_balance(output_state_supul_BS, %{amount: transaction.t1_amount})

    output_nation_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.output_nation_supul_id
      )

    BalanceSheets.plus_t1_balance(output_nation_supul_BS, %{amount: transaction.t1_amount})
  end

  defp update_input_private_IS(transaction) do
    # ? Update IS of buyer's, buyer's family, supul, state_supul, and nation_supul.
    input_is =
      Repo.one(from a in IncomeStatement, where: a.entity_id == ^transaction.input_id, select: a)

    IncomeStatements.add_expense(input_is, %{amount: transaction.t1_amount})

    input_group_is =
      Repo.one(
        from a in IncomeStatement, where: a.group_id == ^transaction.input_group_id, select: a
      )

    IncomeStatements.add_expense(input_group_is, %{amount: transaction.t1_amount})

    input_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.input_supul_id
      )

    IncomeStatements.add_expense(input_supul_is, %{amount: transaction.t1_amount})

    input_state_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.input_state_supul_id
      )

    IncomeStatements.add_expense(input_state_supul_is, %{amount: transaction.t1_amount})

    input_nation_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.input_nation_supul_id
      )

    IncomeStatements.add_expense(input_nation_supul_is, %{amount: transaction.t1_amount})
  end

  defp update_input_private_BS(transaction) do
    # ? Update BS of buyer's, buyer's family, supul, state_supul, and nation_supul.
    input_bs =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.input_id, select: a)

    BalanceSheets.minus_t1_balance(input_bs, %{amount: transaction.t1_amount})

    input_group_bs =
      Repo.one(from a in BalanceSheet, where: a.group_id == ^transaction.input_group_id, select: a)

    BalanceSheets.minus_t1_balance(input_group_bs, %{amount: transaction.t1_amount})

    input_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.supul_id == ^transaction.input_supul_id
      )

    BalanceSheets.minus_t1_balance(input_supul_bs, %{amount: transaction.t1_amount})

    input_state_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.state_supul_id == ^transaction.input_state_supul_id
      )

    BalanceSheets.minus_t1_balance(input_state_supul_bs, %{amount: transaction.t1_amount})

    input_nation_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.input_nation_supul_id
      )

    BalanceSheets.minus_t1_balance(input_nation_supul_bs, %{amount: transaction.t1_amount})
  end

  defp update_output_private_IS(transaction) do
    # ? Update IS of seller's, seller's family, supul, state_supul, and nation_supul.
    output_is =
      Repo.one(from a in IncomeStatement, where: a.entity_id == ^transaction.output_id, select: a)

    IncomeStatements.add_revenue(output_is, %{amount: transaction.t1_amount})

    output_group_is =
      Repo.one(
        from a in IncomeStatement, where: a.group_id == ^transaction.output_group_id, select: a
      )

    IncomeStatements.add_revenue(output_group_is, %{amount: transaction.t1_amount})

    output_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.supul_id == ^transaction.output_supul_id
      )

    IncomeStatements.add_revenue(output_supul_is, %{amount: transaction.t1_amount})

    output_state_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.state_supul_id == ^transaction.output_state_supul_id
      )

    IncomeStatements.add_revenue(output_state_supul_is, %{amount: transaction.t1_amount})

    output_nation_supul_is =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.output_nation_supul_id
      )

    IncomeStatements.add_revenue(output_nation_supul_is, %{amount: transaction.t1_amount})
  end

  defp update_output_private_BS(transaction) do
    # ? Update BS of seller's, seller's family, supul, state_supul, and nation_supul.
    output_bs =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.output_id, select: a)

    BalanceSheets.plus_t1_balance(output_bs, %{amount: transaction.t1_amount})

    output_group_bs =
      Repo.one(from a in BalanceSheet, where: a.group_id == ^transaction.output_group_id, select: a)

    BalanceSheets.plus_t1_balance(output_group_bs, %{amount: transaction.t1_amount})

    output_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.supul_id == ^transaction.output_supul_id
      )

    BalanceSheets.plus_t1_balance(output_supul_bs, %{amount: transaction.t1_amount})

    output_state_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.state_supul_id == ^transaction.output_state_supul_id
      )

    BalanceSheets.plus_t1_balance(output_state_supul_bs, %{amount: transaction.t1_amount})

    output_nation_supul_bs =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.output_nation_supul_id
      )

    BalanceSheets.plus_t1_balance(output_nation_supul_bs, %{amount: transaction.t1_amount})
  end

  defp update_input_public_IS(transaction) do
    # ? trader can be either input or input
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    input_IS =
      Repo.one(from a in IncomeStatement, where: a.entity_id == ^transaction.input_id, select: a)

    IncomeStatements.add_expense(input_IS, %{amount: transaction.t1_amount})

    input_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.input_nation_supul_id
      )

    IncomeStatements.add_expense(input_nation_supul_IS, %{amount: transaction.t1_amount})
  end

  defp update_input_public_BS(transaction) do
    # ? trader can be either input or input
    # ? Update BS of trader, trader's family, supul, state_supul, and nation_supul.
    input_BS =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.input_id, select: a)

    BalanceSheets.minus_t1_balance(input_BS, %{amount: transaction.t1_amount})

    input_nation_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.input_nation_supul_id
      )

    BalanceSheets.minus_t1_balance(input_nation_supul_BS, %{amount: transaction.t1_amount})
  end

  defp update_output_public_IS(transaction) do
    # ? trader can be either input or input
    # ? Update IS of trader, trader's family, supul, state_supul, and nation_supul.
    output_IS =
      Repo.one(from a in IncomeStatement, where: a.entity_id == ^transaction.output_id, select: a)

    IncomeStatements.add_revenue(output_IS, %{amount: transaction.t1_amount})

    output_nation_supul_IS =
      Repo.one(
        from a in IncomeStatement,
          where: a.nation_supul_id == ^transaction.output_nation_supul_id
      )

    IncomeStatements.add_revenue(output_nation_supul_IS, %{amount: transaction.t1_amount})
  end

  defp update_output_public_BS(transaction) do
    # ? trader can be either output or output
    # ? Update BS of trader, trader's family, supul, state_supul, and nation_supul.
    output_BS =
      Repo.one(from a in BalanceSheet, where: a.entity_id == ^transaction.output_id, select: a)

    BalanceSheets.plus_t1_balance(output_BS, %{amount: transaction.t1_amount})

    output_nation_supul_BS =
      Repo.one(
        from a in BalanceSheet,
          where: a.nation_supul_id == ^transaction.output_nation_supul_id
      )

    BalanceSheets.plus_t1_balance(output_nation_supul_BS, %{amount: transaction.t1_amount})
  end

  defp update_t1_balance(transaction) do
    # ? Update t1_balance of both input and input.
    # ? Buyer's t1_balance
    # ? input
    query =
      from b in Entity,
        where: b.id == ^transaction.input_id

    input = Repo.one(query)
    gab_account = Repo.preload(input, :gab_account).gab_account

    # ? output
    query =
      from s in Entity,
        where: s.id == ^transaction.output_id

    output = Repo.one(query)

    amount =
      case input.default_currency == output.default_currency do
        true -> transaction.t1_amount
        false -> Gabs.get_ex_rate(input.default_currency, output.default_currency, transaction.t1_amount)
      end

    GabAccounts.minus_t1_balance(gab_account, %{amount: amount})

    case input.type do
      "default" ->
        query = from f in Family, where: f.id == ^transaction.input_family_id, select: f
        input_family = Repo.one(query)
        Families.minus_t1_balance(input_family, %{amount: transaction.t1_amount})

        query = from s in Supul, where: s.id == ^transaction.input_supul_id, select: s
        input_supul = Repo.one(query)
        Supuls.minus_t1_balance(input_supul, %{amount: transaction.t1_amount})

        query = from s in StateSupul, where: s.id == ^transaction.input_state_supul_id, select: s
        input_state_supul = Repo.one(query)
        StateSupuls.minus_t1_balance(input_state_supul, %{amount: transaction.t1_amount})

        query = from s in NationSupul, where: s.id == ^transaction.input_nation_supul_id, select: s
        input_nation_supul = Repo.one(query)
        NationSupuls.minus_t1_balance(input_nation_supul, %{amount: transaction.t1_amount})

      "private" ->
        query = from g in Group, where: g.id == ^transaction.input_group_id, select: g
        input_group = Repo.one(query)
        Groups.minus_t1_balance(input_group, %{amount: transaction.t1_amount})

        query = from s in Supul, where: s.id == ^transaction.input_supul_id, select: s
        input_supul = Repo.one(query)
        Supuls.minus_t1_balance(input_supul, %{amount: transaction.t1_amount})

        query = from s in StateSupul, where: s.id == ^transaction.input_state_supul_id, select: s
        input_state_supul = Repo.one(query)
        StateSupuls.minus_t1_balance(input_state_supul, %{amount: transaction.t1_amount})

        query = from s in NationSupul, where: s.id == ^transaction.input_nation_supul_id, select: s
        input_nation_supul = Repo.one(query)
        NationSupuls.minus_t1_balance(input_nation_supul, %{amount: transaction.t1_amount})

      "public" ->
        query = from s in NationSupul, where: s.id == ^transaction.input_nation_supul_id, select: s
        input_nation_supul = Repo.one(query)
        NationSupuls.minus_t1_balance(input_nation_supul, %{amount: transaction.t1_amount})
    end

    # ? Seller's t1_balance
    gab_account = Repo.preload(output, :gab_account).gab_account
    GabAccounts.plus_t1_balance(gab_account, %{amount: transaction.t1_amount})

    case output.type do
      "default" ->
        query = from f in Family, where: f.id == ^transaction.output_family_id, select: f
        output_family = Repo.one(query)
        Families.plus_t1_balance(output_family, %{amount: transaction.t1_amount})

        query = from s in Supul, where: s.id == ^transaction.output_supul_id, select: s
        output_supul = Repo.one(query)
        Supuls.plus_t1_balance(output_supul, %{amount: transaction.t1_amount})

        query = from s in StateSupul, where: s.id == ^transaction.output_state_supul_id, select: s
        output_state_supul = Repo.one(query)
        StateSupuls.plus_t1_balance(output_state_supul, %{amount: transaction.t1_amount})

        query = from s in NationSupul, where: s.id == ^transaction.output_nation_supul_id, select: s
        output_nation_supul = Repo.one(query)
        NationSupuls.plus_t1_balance(output_nation_supul, %{amount: transaction.t1_amount})

      "private" ->
        query = from g in Group, where: g.id == ^transaction.output_group_id, select: g
        output_group = Repo.one(query)
        Groups.plus_t1_balance(output_group, %{amount: transaction.t1_amount})

        query = from s in Supul, where: s.id == ^transaction.output_supul_id, select: s
        output_supul = Repo.one(query)
        Supuls.plus_t1_balance(output_supul, %{amount: transaction.t1_amount})

        query = from s in StateSupul, where: s.id == ^transaction.output_state_supul_id, select: s
        output_state_supul = Repo.one(query)
        StateSupuls.plus_t1_balance(output_state_supul, %{amount: transaction.t1_amount})

        query = from s in NationSupul, where: s.id == ^transaction.output_nation_supul_id, select: s
        output_nation_supul = Repo.one(query)
        NationSupuls.plus_t1_balance(output_nation_supul, %{amount: transaction.t1_amount})

      "public" ->
        query = from s in NationSupul, where: s.id == ^transaction.output_nation_supul_id, select: s
        output_nation_supul = Repo.one(query)
        NationSupuls.plus_t1_balance(output_nation_supul, %{amount: transaction.t1_amount})
    end
  end

  defp update_t1s(transaction, openhash) do
    query =
      from b in Entity,
        where: b.id == ^transaction.input_id

    input = Repo.one(query)

    query =
      from s in Entity,
        where: s.id == ^transaction.output_id

    output = Repo.one(query)

    # ? ts of both
    IO.inspect("transaction.t1_amount")

    GabAccounts.renew_t1s(%{amount: transaction.t1_amount}, input, output, openhash)
  end
end
