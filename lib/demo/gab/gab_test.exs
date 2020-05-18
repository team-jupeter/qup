import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

#? init nations
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!
usa = Nation.changeset(%Nation{}, %{name: "USA"}) |> Repo.insert!


#? init supuls. For example, Korea will have about 5,000 supuls.
alias Demo.Supuls.GlobalSupul
alias Demo.Supuls.NationSupul
alias Demo.Supuls.StateSupul
alias Demo.Supuls.Supul

global_supul = GlobalSupul.changeset(%GlobalSupul{}, %{name: "Global Supul", supul_code: 0x00000000}) |> Repo.insert!
korea_supul = NationSupul.changeset(%NationSupul{}, %{name: "Korea Supul", supul_code: 0x52000000}) |> Repo.insert!
jejudo_supul = StateSupul.changeset(%StateSupul{}, %{name: "Jejudo State Supul", supul_code: 0x01434500}) |> Repo.insert!
hankyung_supul = Supul.changeset(%Supul{}, %{name: "Hankyung_County", supul_code: 0x01434501}) |> Repo.insert!


#? init users
alias Demo.Users.User

# {ok, mr_hong} = User.changeset(%User{}, %{name: "Hong Gildong"}) |> Repo.insert
mr_hong = User.changeset(%User{}, %{name: "Hong Gildong", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
ms_sung = User.changeset(%User{}, %{name: "Sung Chunhyang", email: "sung_chun_hyang@82345.kr"}) |> Repo.insert!
gab = User.changeset(%User{}, %{name: "GAB: Global Autonomous Bank", email: "gab@000011.un"}) |> Repo.insert!

#? init entities
alias Demo.Entities.Entity

hong_entity = Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
sung_entity = Entity.changeset(%Entity{}, %{name: "Sung Chunhyang Entity", email: "sung_chun_hyang@82345.kr"}) |> Repo.insert!
hankyung_gab = Entity.changeset(%Entity{}, %{name: "Hankyung GAB Branch", email: "hankyung_gab@3435.kr"}) |> Repo.insert!
nonghyup = Entity.changeset(%Entity{}, %{name: "NongHyup Bank", email: "nonghyup_bank@3335.kr"}) |> Repo.insert!

#? build_assoc user and entity
Repo.preload(hong_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [mr_hong]) |> Repo.update!
Repo.preload(sung_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [ms_sung]) |> Repo.update!
Repo.preload(hankyung_gab, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [gab]) |> Repo.update!


#? make a GAB branch for Hangkyung Supul. Remember every supul has one, only one GAB branch.
hankyung_gab = Ecto.build_assoc(hankyung_supul, :entities, hankyung_gab) 

#? build_assoc hankyung_gab with korea
hankyung_gab = Ecto.build_assoc(korea, :entities, hankyung_gab) 

Repo.preload(hankyung_gab, [:nation, :supul])

#? write invoice for trade between mr_hong and hankyung_gab.
'''
The price of ABC T1, T2, T3 will be updated every second.
The code below is hard coded. We need write codes for invoice_items with only one item.
'''
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
item = Item.changeset(%Item{}, %{gpc_code: "ABCDE11111", category: "ABC_T1", name: "Standard Currency", price: Decimal.from_float(1123.45)}) |> Repo.insert!
invoice_items = [%{item_id: item.id, quantity: 5}, %{item_id: item.id, quantity: 0}]


#? add total to invoice
params = %{
  "buyer" => %{"entity_id" => hong_entity.id},
  "seller" => %{"entity_id" => hankyung_gab.id},
  "invoice_items" => invoice_items
}
{:ok, invoice} = Invoice.create(params)
invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

#? write a ledger
alias Demo.Reports.Ledger

item_id = Enum.at(invoice_items, 0).item_id
item = Repo.one from item in Item,
  where: item.id == ^item_id,
  select: item.category

ledger = Ledger.changeset(%Ledger{}, %{invoice_id: invoice.id, buyer_id: invoice.buyer.entity_id, seller_id: invoice.seller.entity_id, amount: invoice.total, item: item, price: invoice.total}) |> Repo.insert!

#? find the seller entity(hankyung_gab) and the buyer entity
gab_branch = Repo.one from gab_branch in Entity, where: gab_branch.id == ^invoice.seller.entity_id
buyer_entity = Repo.one from entity in Entity, where: entity.id == ^invoice.buyer.entity_id

#? prepare financial report of both
alias Demo.Reports.FinancialReport

buyer_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: buyer_entity.id}) |> Repo.insert!
gab_branch_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: gab_branch.id}) |> Repo.insert!


#? adjust income statement accounts of both.
alias Demo.Reports.BalanceSheet
alias Demo.Reports.IncomeStatement
alias Demo.Reports.CashFlow

buyer_BS = Ecto.build_assoc(buyer_FR, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
gab_branch_BS = Ecto.build_assoc(gab_branch_FR, :balance_sheet, %BalanceSheet{}) |> Repo.insert!

buyer_IS = Ecto.build_assoc(buyer_FR, :income_statement, %IncomeStatement{}) |> Repo.insert!
gab_branch_IS = Ecto.build_assoc(gab_branch_FR, :income_statement, %IncomeStatement{}) |> Repo.insert!







gab_branch = Repo.preload(gab_branch, [financial_report: :income_statement])
gab_branch_IS = change(gab_branch_IS) |>
Ecto.Changeset.put_change(:revenue, Decimal.add(gab_branch_IS.revenue, ledger.amount)) |>
Repo.update!

buyer_entity = Repo.preload(buyer_entity, [financial_report: :income_statement])
buyer_entity_IS = buyer_entity.financial_report.income_statement
buyer_entity_IS = change(buyer_entity_IS) |>
Ecto.Changeset.put_change(:gab_account_t1, Decimal.add(buyer_entity_IS.travel_and_entertainment, ledger.amount)) |>
Repo.update!

