defmodule Demo.BalanceSheets do
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Reports.BalanceSheet
  alias Demo.Entities.Entity
  alias Demo.Groups.Group
  alias Demo.Supuls.Supul
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls.NationSupul
  alias Demo.Taxations.Taxation
  alias Demo.Families.Family
  alias Demo.GabAccounts.GabAccount

  def get_balance_sheet!(id), do: Repo.get!(BalanceSheet, id)

  def get_balance_sheet!(entity_id) do
    BalanceSheet
    |> entity_balance_sheets_query(entity_id)
    |> Repo.all()
  end

  def get_entity_balance_sheet!(entity_id) do
    BalanceSheet
    |> entity_balance_sheets_query(entity_id)
    |> Repo.one()
  end

  defp entity_balance_sheets_query(query, entity_id) do
    from(f in query, where: f.entity_id == ^entity_id)
  end

  # ? Default 
  def create_balance_sheet(attrs \\ %{}) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Repo.insert()
  end

  # ? Taxation 
  def create_balance_sheet(%Taxation{} = taxation, attrs) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:taxation, taxation)
    |> Repo.insert()
  end

  # ? 기업 
  def create_balance_sheet(%Entity{} = entity, attrs) do
    %BalanceSheet{}
    |> BalanceSheet.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  alias Demo.ABC.T1

  def renew_ts(attrs, buyer, seller, openhash) do

    IO.inspect "attrs.amount"
    IO.inspect attrs.amount
    # ? Find buyer's BS
    query =
      from b in BalanceSheet,
        where: b.entity_id == ^buyer.id

    buyer_BS = Repo.one(query)

    # ? renew Buyer's BS T1
    # t_change = Decimal.sub(buyer_BS.gab_balance, attrs.amount)


    IO.inspect "buyer_BS.gab_balance"
    IO.inspect buyer_BS.gab_balance
    # IO.inspect "t_change"
    # IO.inspect t_change

    ts = [
      %T1{
        openhash_id: openhash.id,
        input_id: buyer.id,
        input_name: buyer.name,
        output_id: buyer.id,
        output_name: buyer.name,
        amount: buyer_BS.gab_balance
      }
    ]

    buyer_BS
    |> change
    |> Ecto.Changeset.put_embed(:ts, ts)
    |> Repo.update!()
    |> update_gab_balance()

    # ? renew Seller's BS
    # ? prepare t struct to pay.
    t_payment = %{
      ts: %T1{
        openhash_id: openhash.id,
        input_name: buyer.name,
        input_id: buyer.id,
        output_name: seller.name,
        output_id: seller.id,
        amount: attrs.amount
      }
    }

    # ? Find seller's BS
    query =
      from b in BalanceSheet,
        where: b.entity_id == ^seller.id

    seller_BS = Repo.one(query)

    add_ts(seller_BS, t_payment)
  end

  def add_ts(%BalanceSheet{} = balance_sheet, attrs) do
    ts = [attrs.ts | balance_sheet.ts]
    # IO.puts "T1"
    # IO.inspect ts
    # bs_owner = Repo.preload(balance_sheet, :bs_owner).bs_owner
    # GabAccounts.update_gab_account(%{balance_sheet_id: balance_sheet.id, ts: ts}

    balance_sheet
    |> change
    |> Ecto.Changeset.put_embed(:ts, ts)
    |> Repo.update!()
    |> update_gab_balance()
  end

  def update_gab_balance(bs) do
    amount_list = Enum.map(bs.ts, fn item -> item.amount end)
    gab_balance = Enum.reduce(amount_list, 0, fn amount, sum -> Decimal.add(amount, sum) end)
    update_balance_sheet(bs, %{gab_balance: gab_balance})
  end

  # ? gopang_korea_BS = change(gopang_korea_BS) |> Ecto.Changeset.put_embed(:ts, ts) |> Repo.update!

  def update_balance_sheet(%BalanceSheet{} = balance_sheet, attrs) do
    BalanceSheet.changeset(balance_sheet, attrs)
    |> Repo.update!()
  end

  def minus_gab_balance(%BalanceSheet{} = balance_sheet, %{amount: amount}) do
    new_balance = Decimal.sub(balance_sheet.gab_balance, amount)
    update_balance_sheet(balance_sheet, %{gab_balance: new_balance}) |> IO.inspect()
  end

  def plus_gab_balance(%BalanceSheet{} = balance_sheet, %{amount: amount}) do
    new_balance = Decimal.add(balance_sheet.gab_balance, amount)
    update_balance_sheet(balance_sheet, %{gab_balance: new_balance})
  end

  def change_balance_sheet(%BalanceSheet{} = balance_sheet) do
    BalanceSheet.changeset(balance_sheet, %{})
  end

  '''
    def delete_balance_sheet(%BalanceSheet{} = balance_sheet) do
      Repo.delete(balance_sheet)
    end
  '''

  '''
    Create balance sheets of supuls etc. using already existing members.
  '''

  # # ? 그룹  
  # def create_balance_sheet(%Group{} = group) do
  #   attrs = create_attrs(group)

  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:group, group)
  #   |> Repo.insert()
  # end

  # def create_balance_sheet(%Group{} = group, attrs) do
  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:group, group)
  #   |> Repo.insert()
  # end

  # # ? Family
  # def create_balance_sheet(%Family{} = family) do
  #   attrs = create_attrs(family)

  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:family, family)
  #   |> Repo.insert()
  # end

  # # ? Family
  # def create_balance_sheet(%Family{} = family, attrs) do
  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:family, family)
  #   |> Repo.insert()
  # end

  # # ? Supul  
  # def create_balance_sheet(%Supul{} = supul) do
  #   attrs = create_attrs(supul)

  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:supul, supul)
  #   |> Repo.insert()
  # end
  # # ? Supul  
  # def create_balance_sheet(%Supul{} = supul, attrs) do
  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:supul, supul)
  #   |> Repo.insert()
  # end

  # def create_balance_sheet(%StateSupul{} = state_supul) do
  #   attrs = create_attrs(state_supul)

  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
  #   |> Repo.insert()
  # end

  # def create_balance_sheet(%StateSupul{} = state_supul, attrs) do
  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:state_supul, state_supul)
  #   |> Repo.insert()
  # end

  # def create_balance_sheet(%NationSupul{} = nation_supul) do
  #   attrs = create_attrs(nation_supul)

  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
  #   |> Repo.insert()
  # end

  # def create_balance_sheet(%NationSupul{} = nation_supul, attrs) do
  #   %BalanceSheet{}
  #   |> BalanceSheet.changeset(attrs)
  #   |> Ecto.Changeset.put_assoc(:nation_supul, nation_supul)
  #   |> Repo.insert()
  # end 

  # # ? Group/Supul  
  # defp create_attrs(group_or_supul) do
  #   list_BS =
  #     case group_or_supul do
  #       %Group{} ->
  #         entities = Repo.preload(group_or_supul, :entities).entities
  #         Enum.map(entities, fn entity -> Repo.preload(entity, :balance_sheet).balance_sheet end)

  #       %Supul{} ->
  #         entities = Repo.preload(group_or_supul, :entities).entities
  #         Enum.map(entities, fn entity -> Repo.preload(entity, :balance_sheet).balance_sheet end)

  #       %StateSupul{} ->
  #         supuls = Repo.preload(group_or_supul, :supuls).supuls
  #         Enum.map(supuls, fn supul -> Repo.preload(supul, :balance_sheet).balance_sheet end)

  #       %NationSupul{} ->
  #         state_supuls = Repo.preload(group_or_supul, :state_supuls).state_supuls

  #         Enum.map(state_supuls, fn state_supul ->
  #           Repo.preload(state_supul, :balance_sheet).balance_sheet
  #         end)

  #       _ ->
  #         "error"
  #     end

  #   accounts_payable =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.accounts_payable, acc)
  #     end)

  #   accounts_receivable =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.accounts_receivable, acc)
  #     end)

  #   accrued_liabilities =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.accrued_liabilities, acc)
  #     end)

  #   additional_paid_in_capital =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.additional_paid_in_capital, acc)
  #     end)

  #   cash =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.cash, acc) end)

  #   customer_prepayments =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.customer_prepayments, acc)
  #     end)

  #   fixed_assets =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.fixed_assets, acc)
  #     end)

  #   inventory =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.inventory, acc)
  #     end)

  #   long_term_debt =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.long_term_debt, acc)
  #     end)

  #   marketable_securities =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.marketable_securities, acc)
  #     end)

  #   prepaid_expenses =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.prepaid_expenses, acc)
  #     end)

  #   retained_earnings =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.retained_earnings, acc)
  #     end)

  #   short_term_debt =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.short_term_debt, acc)
  #     end)

  #   stock =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.stock, acc) end)

  #   taxes =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc -> Decimal.add(x.taxes, acc) end)

  #   treasury_stock =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.treasury_stock, acc)
  #     end)

  #   gab_balance =
  #     Enum.reduce(list_BS, Decimal.from_float(0.00), fn x, acc ->
  #       Decimal.add(x.gab_balance, acc)
  #     end)

  #   attrs = %{
  #     accounts_payable: accounts_payable,
  #     accounts_receivable: accounts_receivable,
  #     accrued_liabilities: accrued_liabilities,
  #     additional_paid_in_capital: additional_paid_in_capital,
  #     cash: cash,
  #     customer_prepayments: customer_prepayments,
  #     # fixed_assets: fixed_assets,
  #     # inventory: inventory,
  #     long_term_debt: long_term_debt,
  #     marketable_securities: marketable_securities,
  #     prepaid_expenses: prepaid_expenses,
  #     retained_earnings: retained_earnings,
  #     short_term_debt: short_term_debt,
  #     stock: stock,
  #     taxes: taxes,
  #     treasury_stock: treasury_stock,
  #     gab_balance: gab_balance
  #   }
  # end
end
