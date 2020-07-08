import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

# ? init nations
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!()

# ? init supuls. For example, Korea will have about 5,000 supuls.
alias Demo.GlobalSupuls.GlobalSupul
alias Demo.NationSupuls.NationSupul
alias Demo.StateSupuls.StateSupul
alias Demo.Supuls.Supul
alias Demo.Supuls.Supul
alias Demo.Reports.SupulBalanceSheet
global_supul =
  GlobalSupul.changeset(%GlobalSupul{}, %{name: "Global Supul", supul_code: 0x00000000}) \
  |> Repo.insert!()

korea_supul =
  NationSupul.changeset(%NationSupul{}, %{name: "Korea Supul", supul_code: 0x52000000}) \
  |> Repo.insert!()

jejudo_supul =
  StateSupul.changeset(%StateSupul{}, %{name: "Jejudo State Supul", supul_code: 0x01434500}) \
  |> Repo.insert!()

hankyung_supul =
  Supul.changeset(%Supul{}, %{name: "Hankyung Supul", supul_code: 0x01434500}) \
  |> Repo.insert!()

# ? init users
alias Demo.Accounts.User

# {ok, mr_hong} = User.changeset(%User{}, %{name: "Hong Gildong"}) |> Repo.insert
mr_hong =
  User.changeset(%User{}, %{name: "Hong Gildong", email: "hong_gil_dong@82345.kr"}) \
  |> Repo.insert!()

ms_sung =
  User.changeset(%User{}, %{name: "Sung Chunhyang", email: "sung_chun_hyang@82345.kr"}) \
  |> Repo.insert!()

gab =
  User.changeset(%User{}, %{name: "GAB: Global Autonomous Bank", email: "gab@000011.un"}) \
  |> Repo.insert!()

korea =
  User.changeset(%User{}, %{name: "South Korea", email: "korea@000000.kr"}) |> Repo.insert!()

# ? init entities
alias Demo.Business.Entity

hong_entity =
  Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@8245.kr", entity_address: "제주시 한경면 20-1 해거름전망대"}) \
  |> Repo.insert!()

sung_entity =
  Entity.changeset(%Entity{}, %{name: "Sung Chun Hyang Entity", email: "iamchunhyang@8245.kr", entity_address: "제주시 한경면 20-2 달무리지는 언덕"}) \
  |> Repo.insert!()

tomi_entity =
  Entity.changeset(%Entity{}, %{name: "Tomi Lunch Box", email: "tomi@3532.kr", entity_address: "제주시 한림읍 11-1"}) |> Repo.insert!()

gopang =
  Entity.changeset(%Entity{}, %{name: "Gopang Hankyung", email: "gopang_hankyung@3435.kr"}) |> Repo.insert!()

hankyung_supul =
  Entity.changeset(%Entity{}, %{name: "Hankyung Supul", email: "hankyung@3435.kr"}) |> Repo.insert!()

# ? build_assoc user and entity
Repo.preload(hong_entity, [:users]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:users, [mr_hong])  \
|> Repo.update!()

Repo.preload(tomi_entity, [:users])  \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:users, [ms_sung])  \
|> Repo.update!() 



# ? make a gopang branch for Hangkyung Supul. Remember every supul has one, only one Gopang branch.
gopang = Ecto.build_assoc(hankyung_supul, :gopang, gopang)


# ? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.BalanceSheet
alias Demo.Reports.GabBalanceSheet
alias Demo.Reports.GopangBalanceSheet

gopang_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: gopang.id}) |> Repo.insert!()

hankyung_supul_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: hankyung_supul.id}) |> Repo.insert!()

tomi_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_entity.id}) |> Repo.insert!()

gopang_BS =
  Ecto.build_assoc(gopang_FR, :gov_balance_sheet, %GopangBalanceSheet{
    monetary_unit: "KRW",
    t1s: [%{input: korea.id, output: gopang.id, amount: Decimal.from_float(10_000_000.00)}],
    cashes: [%{KRW: Decimal.from_float(10_000_000_000.00)}]
  }) \
  |> Repo.insert!()

hankyung_supul_BS =
  Ecto.build_assoc(hankyung_supul_FR, :supul_balance_sheet, %SupulBalanceSheet{
    monetary_unit: "KRW",
    t1s: [%{
      input: korea.id, 
      output: hankyung_supul.id, 
      amount: Decimal.from_float(10_000_000.00)}],
      cashes: [%{KRW: Decimal.from_float(10_000_000_000.00)}]
  }) \
  |> Repo.insert!()


tomi_entity_BS =
  Ecto.build_assoc(tomi_entity_FR, :balance_sheet, %BalanceSheet{
    fixed_assets: [%{building: 1.0}],
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]
    }) \
  |> Repo.insert!()

'''

CRYPTO

'''

# ? gopang_entity's private_key or signing key or secret key
# ? openssl genrsa -out hankyung_private_key.pem 2048
# ? openssl rsa -in hankyung_private_key.pem -pubout > hankyung_public_key.pem
hankyung_rsa_priv_key = ExPublicKey.load!("./hankyung_private_key.pem")
hankyung_rsa_pub_key = ExPublicKey.load!("./hankyung_public_key.pem")

gopang_rsa_priv_key = ExPublicKey.load!("./gopang_private_key.pem")
gopang_rsa_pub_key = ExPublicKey.load!("./gopang_public_key.pem")

hong_rsa_priv_key = ExPublicKey.load!("./hong_private_key.pem")
hong_rsa_pub_key = ExPublicKey.load!("./hong_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./tomi_public_key.pem")

'''

TRANSACTION
Let's assume hong is selected as beneficiary of policy finance.
Transaction between gopang and hong_entity.

'''

alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Tickets.Ticket

#? Lunch Box
item_1 =
  Item.changeset(
    %Item{},
    %{
      product_uuid: tomi_entity.id,
      price: Decimal.from_float(1.0),
    }
  ) \
  |> Repo.insert!()

#? Gopang Service
item_2 =
  Item.changeset(
    %Item{},
    %{
      product_uuid: gopang.id,
      price: Decimal.from_float(0.1),
    }
  ) \
  |> Repo.insert!()

# ? issue an ticket
#? For mr_hong
ticket_1 =
  Ticket.changeset(%Ticket{}, %{
    departure: tomi_entity.entity_address,
    destination: hong_entity.entity_address,
    departure_time: "2020-06-23 23:50:07",
    arrival_time: "2020-06-24 00:20:07",
    item_id: item_1.id,
    item_size: [%{width: 10, height: 10, length: 30}],
    item_weight: 980,
    caution: "rotenable",
    gopang_fee: Decimal.from_float(0.1),
  }) \
  |> Repo.insert!()

#? for mz_sung
ticket_2 =
  Ticket.changeset(%Ticket{}, %{
    departure: tomi_entity.entity_address,
    destination: sung_entity.entity_address,
    departure_time: "2020-06-23 23:50:07",
    arrival_time: "2020-06-24 00:20:07",
    item_id: item_2.id,
    item_size: [%{width: 10, height: 10, length: 30}],
    item_weight: 980,
    caution: "rotenable",
    gopang_fee: Decimal.from_float(0.1),
  }) \
  |> Repo.insert!()

#? INVOICE
#? For Lunch Box provider
invoice_items = [
  %{item_id: item_1.id, quantity: 2.0, item_name: "도시락"},
  %{item_id: item_1.id, quantity: 0.0}
]

params = %{
  "buyer" => %{"main" => hankyung_supul.id, "participants" => hankyung_supul.id},
  "seller" => %{"main" => tomi_entity.id, "participants" => tomi_entity.id},
  "invoice_items" => invoice_items
}

{:ok, invoice_1} = Invoice.create(params)

#? For Logistics provider
invoice_items = [
  %{item_id: item_2.id, quantity: 2, item_name: "고팡 서비스"},
  %{item_id: item_2.id, quantity: 0.0}
]

params = %{
  "buyer" => %{"main" => hankyung_supul.id, "participants" => hankyung_supul.id},
  "seller" => %{"main" => gopang.id, "participants" => gopang.id},
  "invoice_items" => invoice_items
}

{:ok, invoice_2} = Invoice.create(params)

# invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

# ? hash_of_invoice = hong_public_sha256 = :crypto.hash(:sha256, invoice)

'''

Route and Ticket

'''
# ? calculate route, then embed it on the ticket. 


# ? Write Transactions
#? For lunch boxes
alias Demo.Transactions.Transaction
transaction_1 =
  Transaction.changeset(%Transaction{
    abc_input: hankyung_supul.id,
    abc_output: tomi_entity.id,
    abc_amount: invoice_1.total,
    items: [%{도시락: 2}],
  }) \
  |> Repo.insert!()

# ? Association between Transaction and Invoice
invoice_1 = Ecto.build_assoc(transaction_1, :invoice, invoice_1)
preloaded_ticket_1 = Repo.preload(ticket_1, [:transaction])

#? For gopang
transaction_2 =
  Transaction.changeset(%Transaction{
    abc_input: hankyung_supul.id,
    abc_output: gopang.id,
    abc_amount: invoice_2.total,
    items: [%{gopang_fee: 2}],
  }) \
  |> Repo.insert!()

# ? Association between Transaction and Invoice
invoice_2 = Ecto.build_assoc(transaction_2, :invoice, invoice_2)
preloaded_ticket_1 = Repo.preload(ticket_1, [:transaction])



#? CAUTION : TICKETS ARE FOR TXN_1 ONLY
ticket_1 = Ecto.build_assoc(transaction_1, :ticket, ticket_1)
ticket_2 = Ecto.build_assoc(transaction_1, :ticket, ticket_2)

#? preload if necessary.
preloaded_ticket_1 = Repo.preload(ticket_1, [:transaction])
preloaded_ticket_2 = Repo.preload(ticket_2, [:transaction])

'''
QUIZ: 
(1) Update BS of gopang, hankyung_supul, and tomi_entity
(2) Write codes for ticket archive by hankyung_mulet
(3) Write codes to check who received lunch box and who not.
(4) Modify archieve codes written at 국가 교통물류 인프라 to archive both tickets and transactions sent by buyers or sellers. 
'''