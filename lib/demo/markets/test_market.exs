import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

# ? init nations
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!()

# ? init supuls. For example, Korea will have about 5,000 supuls.
alias Demo.Supuls.GlobalSupul
alias Demo.Supuls.NationSupul
alias Demo.Supuls.StateSupul
alias Demo.Supuls.Supul

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

mr_lim =
  User.changeset(%User{}, %{name: "Lim Geuk Jung", email: "limgeukjung@88889.kr"}) \
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

lim_entity =
  Entity.changeset(%Entity{}, %{name: "Lim Geuk Jung Entity", email: "limgeukjung@88889@8245.kr", entity_address: "서귀포시 안덕면 77-1"}) \
  |> Repo.insert!()

tomi_entity =
  Entity.changeset(%Entity{}, %{name: "Tomi Lunch Box", email: "tomi@3532.kr", entity_address: "제주시 한림읍 11-1"}) \
  |> Repo.insert!()

gopang =
  Entity.changeset(%Entity{}, %{name: "Gopang Hankyng", email: "gopang_hankyung@3435.kr"}) |> Repo.insert!()

# ? build_assoc user and entity
Repo.preload(hong_entity, [:users]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:users, [mr_hong])  \
|> Repo.update!()

Repo.preload(lim_entity, [:users]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:users, [mr_lim])  \
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

hong_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id}) |> Repo.insert!()

lim_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: lim_entity.id}) |> Repo.insert!()

tomi_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_entity.id}) |> Repo.insert!()




gopang_BS =
  Ecto.build_assoc(gopang_FR, :gov_balance_sheet, %GopangBalanceSheet{
    monetary_unit: "KRW",
    t1s: [%{input: korea.id, output: gopang.id, amount: Decimal.from_float(10_000_000.00)}],
    cashes: [%{KRW: Decimal.from_float(10_000_000_000.00)}]
  }) \
  |> Repo.insert!()

hong_entity_BS =
  Ecto.build_assoc(hong_entity_FR, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]}) \
  |> Repo.insert!()

lim_entity_BS =
  Ecto.build_assoc(lim_entity_FR, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]}) \
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
# ? openssl genrsa -out gopang_private_key.pem 2048
# ? openssl rsa -in gopang_private_key.pem -pubout > gopang_public_key.pem
gopang_rsa_priv_key = ExPublicKey.load!("./gopang_private_key.pem")
gopang_rsa_pub_key = ExPublicKey.load!("./gopang_public_key.pem")

# ? openssl genrsa -out lim_private_key.pem 2048
# ? openssl rsa -in lim_private_key.pem -pubout > lim_public_key.pem
lim_rsa_priv_key = ExPublicKey.load!("./lim_private_key.pem")
lim_rsa_pub_key = ExPublicKey.load!("./lim_public_key.pem")

hong_rsa_priv_key = ExPublicKey.load!("./hong_private_key.pem")
hong_rsa_pub_key = ExPublicKey.load!("./hong_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./tomi_public_key.pem")




'''

PRODUCTS, COMMENTS AND ENTITIES

'''
#? PRODUCTS
alias Demo.Products.Product
alias Demo.Products.CommentEmbed

lunchbox_1 = Product.changeset(%Product{}, %{
  name: "갈비 도시락", 
  price: Decimal.from_float(1.0), 
  gpc_code: "ADF3455", 
}) |> Repo.insert!


lunchbox_2 = Product.changeset(%Product{}, %{
  name: "스시 도시락", 
  price: Decimal.from_float(2.0), 
  gpc_code: "ADF5555", \
}) |> Repo.insert!


#? COMMENTS
comment_1 = CommentEmbed.changeset(%CommentEmbed{}, %{
  product_id: lunchbox_1.id,
  written_by: hong_entity.id,
  content: "잘도 맛나요.",
  stars: 5,
  })

comment_2 = CommentEmbed.changeset(%CommentEmbed{}, %{
  product_id: lunchbox_1.id,
  written_by: lim_entity.id,
  content: "나름 먹을만하다능.",
  stars: 3
  }) 

comment_3 = CommentEmbed.changeset(%CommentEmbed{}, %{
  product_id: lunchbox_2.id,
  written_by: lim_entity.id,
  content: "맛없어요.",
  stars: 1
  }) 

#? Put_Embed between tomi's products and comments.
lunchbox_1 = change(lunchbox_1) \
    |> Ecto.Changeset.put_embed(:comments, [comment_1, comment_2]) \
    |> Repo.update!

lunchbox_2 = change(lunchbox_2) \
    |> Ecto.Changeset.put_embed(:comments, [comment_3]) \
    |> Repo.update!
#? end


#? PRODUCTS AND ENTITIES == MANY_TO_MANY
Repo.preload(tomi_entity, [:products]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:products, [lunchbox_1, lunchbox_2])  \
|> Repo.update!()



'''

TRANSACTION
Let's assume hong is selected as beneficiary of policy finance.
Transaction between gopang and hong_entity.

'''

alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Tickets.Ticket

#? Lunch Box 1
item_1 = #? "갈비 도시락"
  Item.changeset(
    %Item{},
    %{
      product_uuid: lunchbox_1.id,
      price: lunchbox_1.price,
    }
  ) \
  |> Repo.insert!()

#? Lunch Box 2
item_2 = #? "스시 도시락"
  Item.changeset(
    %Item{},
    %{
      product_uuid: lunchbox_2.id,
      price: lunchbox_2.price,
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
    destination: lim_entity.entity_address,
    departure_time: "2020-06-23 23:50:07",
    arrival_time: "2020-06-24 00:20:07",
    item_id: item_2.id,
    item_size: [%{width: 10, height: 10, length: 30}],
    item_weight: 980,
    caution: "rotenable",
    gopang_fee: Decimal.from_float(0.1),
    # distance: 
  }) \
  |> Repo.insert!()

#? INVOICE
#? For Lunch Box provider
invoice_items_1 = [
  %{item_id: item_1.id, quantity: 1.0, item_name: "갈비 도시락"},
  %{item_id: item_1.id, quantity: 0.0, item_name: "갈비 도시락"}
]
params_1 = %{
  "buyer" => %{"main" => hong_entity.id, "participants" => hong_entity.id},
  "seller" => %{"main" => tomi_entity.id, "participants" => tomi_entity.id},
  "invoice_items" => invoice_items_1
}
{:ok, invoice_1} = Invoice.create(params_1)



#? Rewrite codes to calculate subtotal of invoice_items regarless of the number of items sold. 
invoice_items_2 = [
  %{item_id: item_2.id, quantity: 1.0, item_name: "스시 도시락"},
  %{item_id: item_2.id, quantity: 0.0, item_name: "스시 도시락"}
]

params_2 = %{
  "buyer" => %{"main" => lim_entity.id, "participants" => lim_entity.id},
  "seller" => %{"main" => tomi_entity.id, "participants" => tomi_entity.id},
  "invoice_items" => invoice_items_2
}
{:ok, invoice_2} = Invoice.create(params_2)


# invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

# ? hash_of_invoice = hong_public_sha256 = :crypto.hash(:sha256, invoice)



'''

Tickets & Transactions

'''
# ? calculate route, then embed it on the ticket. 


# ? Write Transactions
#? For lunch box 1
alias Demo.Transactions.Transaction
txn_1 =
  Transaction.changeset(%Transaction{
    abc_input: hong_entity.id,
    abc_output: tomi_entity.id,
    abc_amount: invoice_1.total,
    items: [item_1.id],
  }) \
  |> Repo.insert!()

# ? Association between Transaction and Invoice
invoice_1 = Ecto.build_assoc(txn_1, :invoice, invoice_1)

#? For lunch box 2
txn_2 =
  Transaction.changeset(%Transaction{
    abc_input: lim_entity.id,
    abc_output: gopang.id,
    abc_amount: invoice_2.total,
    items: [item_2.id],
  }) \
  |> Repo.insert!()

invoice_2 = Ecto.build_assoc(txn_2, :invoice, invoice_2)


# ? Association between Transaction and Invoice
# invoice_1 = Ecto.build_assoc(txn_1, :invoice, invoice_1)
# invoice_2 = Ecto.build_assoc(txn_2, :invoice, invoice_2)
# preloaded_ticket_1 = Repo.preload(ticket_1, [:transaction])



#? TICKETS ARE FOR TXN_1 ONLY
ticket_1 = Ecto.build_assoc(txn_1, :ticket, ticket_1)
ticket_2 = Ecto.build_assoc(txn_2, :ticket, ticket_2)

#? preload if necessary.
preloaded_ticket_1 = Repo.preload(ticket_1, [:transaction])
preloaded_ticket_2 = Repo.preload(ticket_2, [:transaction])


'''

SUPUL

'''
#? SAME TO THE PROCESS SHOWN AT 국가 교통물류 인프라. 










'''
QUIZ: 
(1) Write code to calculate gopang_fee of each item depending on distance between buyer and seller.
(2) Write code to calculate the PVR(가성비, price_to_value_ratio) of each product.
(3) Write code to calcualte the credit rate(from AAA to FFF) of the seller using the PVRs of products it sells.
(4) Write code to reflect the credit rate of evaluators or consumers.  

'''