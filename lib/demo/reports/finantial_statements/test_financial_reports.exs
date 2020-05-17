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

korea_supul = NationSupul.changeset(%NationSupul{}, %{name: "Korea Supul", global_supul_id: global_supul.id, supul_code: 0x52000000}) |> Repo.insert!
usa_supul = NationSupul.changeset(%NationSupul{}, %{name: "USA Supul", global_supul_id: global_supul.id, supul_code: 0x01000000}) |> Repo.insert!

jejudo_supul = StateSupul.changeset(%StateSupul{}, %{name: "Jejudo State Supul", nation_supul_id: korea_supul.id, supul_code: 0x01434500}) |> Repo.insert!
new_york_supul = StateSupul.changeset(%StateSupul{}, %{name: "New York State Supul", nation_supul_id: korea_supul.id, supul_code: 0x01223400}) |> Repo.insert!

hankyung_supul = Supul.changeset(%Supul{}, %{name: "Hankyung_County", state_supul_id: jejudo_supul.id, supul_code: 0x01434501}) |> Repo.insert!
hallim_supul = Supul.changeset(%Supul{}, %{name: "Hallim_County", state_supul_id: jejudo_supul.id, supul_code: 0x01434502}) |> Repo.insert!
orange_supul = Supul.changeset(%Supul{}, %{name: "Orange_County", state_supul_id: new_york_supul.id, supul_code: 0x01223401}) |> Repo.insert!

Repo.preload(jejudo_supul, [:supuls]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:supuls, [hankyung_supul, hallim_supul]) |> Repo.update!
Repo.preload(new_york_supul, [:supuls]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:supuls, [orange_supul]) |> Repo.update!

Repo.preload(korea_supul, [:state_supuls]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:state_supuls, [jejudo_supul]) |> Repo.update!
Repo.preload(usa_supul, [:state_supuls]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:state_supuls, [new_york_supul]) |> Repo.update!
Repo.preload(global_supul, [:nation_supuls]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:nation_supuls, [korea_supul, usa_supul]) |> Repo.update!

Repo.preload(global_supul, [nation_supuls: :state_supuls])


#? init users
alias Demo.Users.User

{ok, mr_hong} = User.changeset(%User{}, %{nation_id: korea.id, name: "Hong Gildong", supul_id: hankyung_supul.id}) |> Repo.insert
{ok, ms_sung} = User.changeset(%User{}, %{nation_id: korea.id, name: "Sung Chunhyang", supul_id: hankyung_supul.id}) |> Repo.insert
{ok, peter} = User.changeset(%User{}, %{nation_id: korea.id, name: "Peter Ju", supul_id: hankyung_supul.id}) |> Repo.insert
{ok, trump} = User.changeset(%User{}, %{nation_id: usa.id, name: "Donald Trump", supul_id: orange_supul.id}) |> Repo.insert


#? init taxations: kts = korea tax service, irs = internal revenue service
alias Demo.Taxations.Taxation

kts = Taxation.changeset(%Taxation{}, %{name: "Korea Tax Service", nation_id: korea.id}) |> Repo.insert!
irs = Taxation.changeset(%Taxation{}, %{name: "US Internal Revenue Service", nation_id: usa.id}) |> Repo.insert!


#? init entities
alias Demo.Entities.Entity

hs_entity = Entity.changeset(%Entity{}, %{category: "hairshop", name: "Hong & Sung's Hair", nation_id: korea.id, email: "hs@82345.kr", supul_id: hankyung_supul.id, taxation_id: kts.id}) |> Repo.insert!
tomi_entity = Entity.changeset(%Entity{}, %{category: "food", name: "Tomi Kimbab", nation_id: korea.id, email: "tomi@82345.kr", supul_id: hallim_supul.id, taxation_id: kts.id}) |> Repo.insert!
clinic_entity = Entity.changeset(%Entity{}, %{category: "clinic", name: "Peter Clinic", nation_id: korea.id, email: "peter@82345.kr", supul_id: hallim_supul.id, taxation_id: kts.id}) |> Repo.insert!
delta_entity = Entity.changeset(%Entity{}, %{category: "airline", name: "Delta Airline", nation_id: usa.id, email: "delta@023357.us", supul_id: orange_supul.id, taxation_id: irs.id}) |> Repo.insert!


#? users_entities
alias Demo.Entities.Entity
alias Demo.Users.User
alias Demo.Users

Repo.preload(hs_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [ms_sung, mr_hong]) |> Repo.update!
Repo.preload(tomi_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [mr_hong]) |> Repo.update!
Repo.preload(clinic_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [peter]) |> Repo.update!
Repo.preload(delta_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [trump, ms_sung]) |> Repo.update!


#? init financial_reports for a few entities and supuls.
alias Demo.Reports.FinancialReport

#? entity report
hs_report = FinancialReport.changeset(%FinancialReport{}, %{entity_id: hs_entity.id}) |> Repo.insert!
tomi_report = FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_entity.id}) |> Repo.insert!
clinic_report = FinancialReport.changeset(%FinancialReport{}, %{entity_id: clinic_entity.id}) |> Repo.insert!
delta_report = FinancialReport.changeset(%FinancialReport{}, %{entity_id: delta_entity.id}) |> Repo.insert!

#? county report
hankyung_report = FinancialReport.changeset(%FinancialReport{}, %{supul_id: hankyung_supul.id}) |> Repo.insert!
hallim_report = FinancialReport.changeset(%FinancialReport{}, %{supul_id: hallim_supul.id}) |> Repo.insert!
orange_report = FinancialReport.changeset(%FinancialReport{}, %{supul_id: orange_supul.id}) |> Repo.insert!

#? state report
jejudo_report = FinancialReport.changeset(%FinancialReport{}, %{state_supul_id: jejudo_supul.id}) |> Repo.insert!
new_york_report = FinancialReport.changeset(%FinancialReport{}, %{state_supul_id: new_york_supul.id}) |> Repo.insert!

#? nation report
korea_report = FinancialReport.changeset(%FinancialReport{}, %{nation_supul_id: korea_supul.id}) |> Repo.insert!
usa_report = FinancialReport.changeset(%FinancialReport{}, %{nation_supul_id: usa_supul.id}) |> Repo.insert!

#? global report
global_report = FinancialReport.changeset(%FinancialReport{}, %{global_supul_id: global_supul.id}) |> Repo.insert!

#? test
Repo.preload(korea_report, [:nation_supul])

#? init the sheets of each financial_report.
alias Demo.Reports.BalanceSheet
alias Demo.Reports.IncomeStatement
alias Demo.Reports.CashFlow

#? add BalanceSheet to a FinancialReport
hs_bs = Ecto.build_assoc(hs_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
tomi_bs = Ecto.build_assoc(tomi_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
clinic_bs = Ecto.build_assoc(clinic_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
delta_bs = Ecto.build_assoc(delta_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!

hankyung_bs = Ecto.build_assoc(hankyung_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
hallim_bs = Ecto.build_assoc(hallim_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
orange_bs = Ecto.build_assoc(orange_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!

jejudo_bs = Ecto.build_assoc(jejudo_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
new_york_bs = Ecto.build_assoc(new_york_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!

korea_bs = Ecto.build_assoc(korea_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
usa_bs = Ecto.build_assoc(usa_report, :balance_sheet, %BalanceSheet{}) |> Repo.insert!


#? add IncomeStatement to a FinancialReport
hs_is = Ecto.build_assoc(hs_report, :income_statement, %IncomeStatement{}) |> Repo.insert!
tomi_is = Ecto.build_assoc(tomi_report, :income_statement, %IncomeStatement{}) |> Repo.insert!
clinic_is = Ecto.build_assoc(clinic_report, :income_statement, %IncomeStatement{}) |> Repo.insert!
delta_is = Ecto.build_assoc(delta_report, :income_statement, %IncomeStatement{}) |> Repo.insert

hankyung_is = Ecto.build_assoc(hankyung_report, :income_statement, %IncomeStatement{}) |> Repo.insert!
hallim_is = Ecto.build_assoc(hallim_report, :income_statement, %IncomeStatement{}) |> Repo.insert!
orange_is = Ecto.build_assoc(orange_report, :income_statement, %IncomeStatement{}) |> Repo.insert!

jejudo_is = Ecto.build_assoc(jejudo_report, :income_statement, %IncomeStatement{}) |> Repo.insert!
new_york_is = Ecto.build_assoc(new_york_report, :income_statement, %IncomeStatement{}) |> Repo.insert!

korea_is = Ecto.build_assoc(korea_report, :income_statement, %IncomeStatement{}) |> Repo.insert!
usa_is = Ecto.build_assoc(usa_report, :income_statement, %IncomeStatement{}) |> Repo.insert!

#? test
Repo.preload(orange_report, [:income_statement])

#? add CashFlow to a FinancialReport
hs_cf = Ecto.build_assoc(hs_report, :cash_flow, %CashFlow{}) |> Repo.insert!
tomi_cf = Ecto.build_assoc(tomi_report, :cash_flow, %CashFlow{}) |> Repo.insert!
clinic_cf = Ecto.build_assoc(clinic_report, :cash_flow, %CashFlow{}) |> Repo.insert!
delta_cf = Ecto.build_assoc(delta_report, :cash_flow, %CashFlow{}) |> Repo.insert

hankyung_cf = Ecto.build_assoc(hankyung_report, :cash_flow, %CashFlow{}) |> Repo.insert!
hallim_cf = Ecto.build_assoc(hallim_report, :cash_flow, %CashFlow{}) |> Repo.insert!
orange_cf = Ecto.build_assoc(orange_report, :cash_flow, %CashFlow{}) |> Repo.insert!

jejudo_cf = Ecto.build_assoc(jejudo_report, :cash_flow, %CashFlow{}) |> Repo.insert!
new_york_cf = Ecto.build_assoc(new_york_report, :cash_flow, %CashFlow{}) |> Repo.insert!

korea_cf = Ecto.build_assoc(korea_report, :cash_flow, %CashFlow{}) |> Repo.insert!
usa_cf = Ecto.build_assoc(usa_report, :cash_flow, %CashFlow{}) |> Repo.insert!

#? test
Repo.preload(hs_report, [:balance_sheet, :income_statement, :cash_flow, :entity])

_ = '''
INVOICE CONTEXT
'''

#? item => invoice_item => invoice
#? item
alias Demo.Invoices.{Item, Invoice, InvoiceItem}

item1 = Item.changeset(%Item{}, %{gpc_code: "ABCDE1001", category: "air_ticket", name: "Jeju-Incheon", price: Decimal.new(100)}) |> Repo.insert!
item2 = Item.changeset(%Item{}, %{gpc_code: "ABCDE1003", category: "air_ticket", name: "Incheon_NewYork", price: Decimal.new(250)}) |> Repo.insert!

invoice_items = [%{item_id: item1.id, quantity: 5}, %{item_id: item1.id, quantity: 1}]


#? add total to invoice
params = %{
  "buyer" => %{"entity_id" => clinic_entity.id},
  "seller" => %{"entity_id" => delta_entity.id},
  "invoice_items" => invoice_items
}
{:ok, invoice} = Invoice.create(params)
invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

#? write a ledger
alias Demo.Reports.Ledger

item_1_id = Enum.at(invoice_items, 0).item_id
item = Repo.one from item in Item,
  where: item.id == ^item_1_id,
  select: item.category

ledger = Ledger.changeset(%Ledger{}, %{invoice_id: invoice.id, buyer_id: invoice.buyer.entity_id, seller_id: invoice.seller.entity_id, amount: invoice.total, item: item, price: invoice.total}) |> Repo.insert!

'''
The system will double check entries.
1) we will adjust the financial statements of each entity.
2) Also, we adjst the financial statements of supuls, state supuls, and nation supuls.
3) A supul will compare each account value of its financial statements with new values calculated by below (4).
4) A supul add all the amounts of the same account of all entities' financial statements which belong to itself.
5) numbers from (2) and (4) are compared to check their correctness.
'''

#? find the seller entity and the buyer entity, and adjust their accounts.
seller_entity = Repo.one from entity in Entity,
  where: entity.id == ^invoice.seller.entity_id

buyer_entity = Repo.one from entity in Entity,
  where: entity.id == ^invoice.buyer.entity_id


seller_entity = Repo.preload(seller_entity, [financial_report: :income_statement])
buyer_entity = Repo.preload(buyer_entity, [financial_report: :income_statement])

seller_entity_IS = seller_entity.financial_report.income_statement
seller_entity_IS = change(seller_entity_IS) |>
Ecto.Changeset.put_change(:revenue, Decimal.add(seller_entity_IS.revenue, ledger.amount)) |>
Repo.update!

buyer_entity_IS = buyer_entity.financial_report.income_statement
buyer_entity_IS = change(buyer_entity_IS) |>
Ecto.Changeset.put_change(:travel_and_entertainment, Decimal.add(buyer_entity_IS.travel_and_entertainment, ledger.amount)) |>
Repo.update!


#? find the seller supul and the buyer supul, and adjust their accounts.
seller_supul_id = Repo.one from entity in Entity,
  where: entity.id == ^invoice.seller.entity_id,
  select: entity.supul_id


buyer_supul_id = Repo.one from entity in Entity,
  where: entity.id == ^invoice.buyer.entity_id,
  select: entity.supul_id


seller_supul = Repo.one from supul in Supul,
  where: supul.id == ^seller_supul_id

buyer_supul = Repo.one from supul in Supul,
  where: supul.id == ^buyer_supul_id

seller_supul = Repo.preload(seller_supul, [financial_report: :income_statement])
buyer_supul = Repo.preload(buyer_supul, [financial_report: :income_statement])

seller_supul_IS = seller_supul.financial_report.income_statement
seller_supul_IS = change(seller_supul_IS) |> Ecto.Changeset.put_change(:revenue, Decimal.add(seller_supul.financial_report.income_statement.revenue, ledger.amount)) |> Repo.update!

buyer_supul_IS = buyer_supul.financial_report.income_statement
buyer_supul_IS = change(buyer_supul_IS) |> Ecto.Changeset.put_change(:travel_and_entertainment, Decimal.add(buyer_supul.financial_report.income_statement.travel_and_entertainment, ledger.amount)) |> Repo.update!

#? find the seller state_supul and the buyer state_supul, and adjust their accounts.
alias Demo.Supuls.StateSupul

seller_state_supul = Repo.one from state_supul in StateSupul,
  where: state_supul.id == ^seller_supul.state_supul_id

buyer_state_supul = Repo.one from state_supul in StateSupul,
  where: state_supul.id == ^buyer_supul.state_supul_id


seller_state_supul = Repo.preload(seller_state_supul, [financial_report: :income_statement])
buyer_state_supul = Repo.preload(buyer_state_supul, [financial_report: :income_statement])

seller_state_supul_IS = seller_state_supul.financial_report.income_statement
seller_state_supul_IS = change(seller_state_supul_IS) |> Ecto.Changeset.put_change(:revenue, Decimal.add(seller_state_supul.financial_report.income_statement.revenue, ledger.amount)) |> Repo.update!

buyer_state_supul_IS = buyer_state_supul.financial_report.income_statement
buyer_state_supul_IS = change(buyer_state_supul_IS) |> Ecto.Changeset.put_change(:travel_and_entertainment, Decimal.add(buyer_state_supul.financial_report.income_statement.travel_and_entertainment, ledger.amount)) |> Repo.update!

#? find the seller state_supul and the buyer state_supul, and adjust their accounts.
alias Demo.Supuls.NationSupul

seller_nation_supul = Repo.one from nation_supul in NationSupul,
  where: nation_supul.id == ^seller_state_supul.nation_supul_id

buyer_nation_supul = Repo.one from nation_supul in NationSupul,
  where: nation_supul.id == ^buyer_state_supul.nation_supul_id


seller_nation_supul = Repo.preload(seller_nation_supul, [financial_report: :income_statement])
buyer_nation_supul = Repo.preload(buyer_nation_supul, [financial_report: :income_statement])

seller_nation_supul_IS = seller_nation_supul.financial_report.income_statement
seller_nation_supul_IS = change(seller_nation_supul_IS) |> Ecto.Changeset.put_change(:revenue, Decimal.add(seller_nation_supul.financial_report.income_statement.revenue, ledger.amount)) |> Repo.update!

buyer_nation_supul_IS = buyer_nation_supul.financial_report.income_statement
buyer_nation_supul_IS = change(buyer_nation_supul_IS) |> Ecto.Changeset.put_change(:travel_and_entertainment, Decimal.add(buyer_nation_supul.financial_report.income_statement.travel_and_entertainment, ledger.amount)) |> Repo.update!




= '''
Another invoice
'''

#? item => invoice_item => invoice
#? item
alias Demo.Invoices.{Item, Invoice, InvoiceItem}

item3 = Item.changeset(%Item{}, %{gpc_code: "ABCDE1021", category: "food", name: "김밥", price: Decimal.from_float(1.5)}) |> Repo.insert!
item4 = Item.changeset(%Item{}, %{gpc_code: "ABCDE1033", category: "food", name: "떡볶이", price: Decimal.from_float(2.0)}) |> Repo.insert!

invoice_items = [%{item_id: item3.id, quantity: 2}, %{item_id: item4.id, quantity: 3}]


#? add total to invoice
params = %{
  "buyer" => %{"entity_id" => clinic_entity.id},
  "seller" => %{"entity_id" => tomi_entity.id},
  "invoice_items" => invoice_items
}
{:ok, invoice_2} = Invoice.create(params)
invoice_2 = change(invoice_2) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice_2.invoice_items, 0).subtotal, Enum.at(invoice_2.invoice_items, 1).subtotal)) |> Repo.update!

#? write a ledger
alias Demo.Reports.Ledger

item = Repo.one from item in Item,
  where: item.id == ^item3.id,
  select: item.category

ledger_2 = Ledger.changeset(%Ledger{}, %{invoice_id: invoice.id, buyer_id: invoice.buyer.entity_id, seller_id: invoice.seller.entity_id, amount: invoice.total, item: item, price: invoice.total}) |> Repo.insert!

#? find the seller entity and the buyer entity, and adjust their accounts in Income Statement.
seller_entity = Repo.one from entity in Entity,
  where: entity.id == ^invoice_2.seller.entity_id

buyer_entity = Repo.one from entity in Entity,
  where: entity.id == ^invoice_2.buyer.entity_id


seller_entity = Repo.preload(seller_entity, [financial_report: :income_statement])
buyer_entity = Repo.preload(buyer_entity, [financial_report: :income_statement])

seller_entity_IS = seller_entity.financial_report.income_statement
seller_entity_IS = change(seller_entity_IS) |>
Ecto.Changeset.put_change(:revenue, Decimal.add(seller_entity_IS.revenue, ledger.amount)) |>
Repo.update!

buyer_entity_IS = buyer_entity.financial_report.income_statement
buyer_entity_IS = change(buyer_entity_IS) |>
Ecto.Changeset.put_change(:employee_benefits, Decimal.add(buyer_entity_IS.income_statement.employee_benefits, ledger.amount)) |>
Repo.update!


#? find the seller supul and the buyer supul, and adjust their accounts.
seller_supul_id = Repo.one from entity in Entity,
  where: entity.id == ^invoice_2.seller.entity_id,
  select: entity.supul_id


buyer_supul_id = Repo.one from entity in Entity,
  where: entity.id == ^invoice_2.buyer.entity_id,
  select: entity.supul_id


seller_supul = Repo.one from supul in Supul,
  where: supul.id == ^seller_supul_id

buyer_supul = Repo.one from supul in Supul,
  where: supul.id == ^buyer_supul_id

seller_supul = Repo.preload(seller_supul, [financial_report: :income_statement])
buyer_supul = Repo.preload(buyer_supul, [financial_report: :income_statement])

seller_supul_IS = seller_supul.financial_report.income_statement
seller_supul_IS = change(seller_supul_IS) |>
  Ecto.Changeset.put_change(:revenue, Decimal.add(seller_supul_IS.revenue, ledger.amount)) |>
  Repo.update!

buyer_supul_IS = buyer_supul.financial_report.income_statement
buyer_supul_IS = change(buyer_supul_IS) |>
  Ecto.Changeset.put_change(:employee_benefits, Decimal.add(buyer_supul_IS.employee_benefits, ledger.amount)) |>
  Repo.update!

#? consolidate seller_supul_IS and buyer_supul_IS.




#? find the seller state_supul and the buyer state_supul, and adjust their accounts.
alias Demo.Supuls.StateSupul

seller_state_supul = Repo.one from state_supul in StateSupul,
  where: state_supul.id == ^seller_supul.state_supul_id

buyer_state_supul = Repo.one from state_supul in StateSupul,
  where: state_supul.id == ^buyer_supul.state_supul_id


seller_state_supul = Repo.preload(seller_state_supul, [financial_report: :income_statement])
buyer_state_supul = Repo.preload(buyer_state_supul, [financial_report: :income_statement])

seller_state_supul_IS = seller_state_supul.financial_report.income_statement
seller_state_supul_IS = change(seller_state_supul_IS) |> Ecto.Changeset.put_change(:revenue, Decimal.add(seller_state_supul.financial_report.income_statement.revenue, ledger.amount)) |> Repo.update!

buyer_state_supul_IS = buyer_state_supul.financial_report.income_statement
buyer_state_supul_IS = change(buyer_state_supul_IS) |> Ecto.Changeset.put_change(:employee_benefits:, Decimal.add(buyer_state_supul.financial_report.income_statement.travel_and_entertainment, ledger.amount)) |> Repo.update!

#? find the seller state_supul and the buyer state_supul, and adjust their accounts.
alias Demo.Supuls.NationSupul

seller_nation_supul = Repo.one from nation_supul in NationSupul,
  where: nation_supul.id == ^seller_state_supul.nation_supul_id

buyer_nation_supul = Repo.one from nation_supul in NationSupul,
  where: nation_supul.id == ^buyer_state_supul.nation_supul_id


seller_nation_supul = Repo.preload(seller_nation_supul, [financial_report: :income_statement])
buyer_nation_supul = Repo.preload(buyer_nation_supul, [financial_report: :income_statement])

seller_nation_supul_IS = seller_nation_supul.financial_report.income_statement
seller_nation_supul_IS = change(seller_nation_supul_IS) |> Ecto.Changeset.put_change(:revenue, Decimal.add(seller_nation_supul.financial_report.income_statement.revenue, ledger.amount)) |> Repo.update!

buyer_nation_supul_IS = buyer_nation_supul.financial_report.income_statement
buyer_nation_supul_IS = change(buyer_nation_supul_IS) |> Ecto.Changeset.put_change(:travel_and_entertainment, Decimal.add(buyer_nation_supul.financial_report.income_statement.travel_and_entertainment, ledger.amount)) |> Repo.update!

