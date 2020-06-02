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
alias Demo.Users.User

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
alias Demo.Entities.Entity

hong_entity =
  Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@8245.kr", entity_address: "제주시 한경면 20-1 해거름전망대"}) \
  |> Repo.insert!()

sung_entity =
  Entity.changeset(%Entity{}, %{name: "Sung Chun Hyang Entity", email: "chunhyang@8245.kr", entity_address: "제주시 한경면 1-1 노란지붕 우리집"}) \
  |> Repo.insert!()


tomi_clinic =
  Entity.changeset(%Entity{}, %{name: "Tomi Clinic", email: "tomi@3532.kr", entity_address: "제주시 한림읍 11-1"}) \
  |> Repo.insert!()

# ? build_assoc user and entity
Repo.preload(hong_entity, [:users]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:users, [mr_hong])  \
|> Repo.update!()

Repo.preload(tomi_clinic, [:users])  \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:users, [ms_sung])  \
|> Repo.update!() 



# ? make a gopang branch for Hangkyung Supul. Remember every supul has one, only one Gopang branch.


# ? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.BalanceSheet
alias Demo.Reports.GabBalanceSheet
alias Demo.Reports.GopangBalanceSheet

gopang_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: gopang.id}) |> Repo.insert!()

hong_entity_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id}) |> Repo.insert!()

tomi_clinic_FR =
  FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_clinic.id}) |> Repo.insert!()


hong_entity_BS =
  Ecto.build_assoc(hong_entity_FR, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]}) \
  |> Repo.insert!()

tomi_clinic_BS =
  Ecto.build_assoc(tomi_clinic_FR, :balance_sheet, %BalanceSheet{}) \
  |> Repo.insert!()


'''

CRYPTO

'''
hong_rsa_priv_key = ExPublicKey.load!("./hong_private_key.pem")
hong_rsa_pub_key = ExPublicKey.load!("./hong_public_key.pem")

# ? openssl genrsa -out sung_private_key.pem 2048
# ? openssl rsa -in sung_private_key.pem -pubout > sung_public_key.pem
sung_rsa_priv_key = ExPublicKey.load!("./sung_private_key.pem")
sung_rsa_pub_key = ExPublicKey.load!("./sung_public_key.pem")

# ? openssl genrsa -out korea_private_key.pem 2048
# ? openssl rsa -in korea_private_key.pem -pubout > korea_public_key.pem
korea_rsa_priv_key = ExPublicKey.load!("./korea_private_key.pem")
korea_rsa_pub_key = ExPublicKey.load!("./korea_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./tomi_public_key.pem")




'''

DOCTOR CERTIFICATE

'''








'''

CLINIC LICENSE

'''






'''

TEST REPORT

'''
alias Demo.CDC.HealthReport
alias Demo.CDC.Diagnosis
health_report = HealthReport.changeset(%HealthReport{}, %{user_id: hong_entity.id}) |> Repo.insert!
diagnosis = Diagnosis.changeset(%Diagnosis{}, %{client: hong_entity.id, doctor: sung_entity.id, clinic: tomi_clinic.id, test_name: "HIV Test", meditations: ["multivitamins"]}) |> Repo.insert!












'''

PRODUCTS, COMMENTS AND ENTITIES

'''
#? PRODUCTS
alias Demo.Products.Product
alias Demo.Products.CommentEmbed

hiv_test = Product.changeset(%Product{}, %{
  name: "HIV 검사", 
  price: Decimal.from_float(1.0), 
  gpc_code: "ABB1111", 
}) |> Repo.insert!



#? PRODUCTS AND ENTITIES == MANY_TO_MANY
Repo.preload(tomi_clinic, [:products]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:products, [hiv_test])  \
|> Repo.update!()



'''

TRANSACTION
Let's assume hong is selected as beneficiary of policy finance.
Transaction between gopang and hong_entity.

'''

alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Tickets.Ticket

#? ITEM
item = #? "HIV Test"
  Item.changeset(
    %Item{},
    %{
      product_uuid: hiv_test.id,
      price: hiv_test.price,
    }
  ) \
  |> Repo.insert!()

# ? issue an ticket
#? For mr_hong
ticket =
  Ticket.changeset(%Ticket{}, %{
    item_id: hiv_test.id,
  }) \
  |> Repo.insert!()

#? INVOICE
#? For Lunch Box provider
invoice_items = [
  %{item_id: item.id, quantity: 1.0, item_name: "HIV Test"},
  %{item_id: item.id, quantity: 0.0}
]
params = %{
  "buyer" => %{"main" => hong_entity.id, "participants" => hong_entity.id},
  "seller" => %{"main" => tomi_clinic.id, "participants" => tomi_clinic.id},
  "invoice_items" => invoice_items
}
{:ok, invoice} = Invoice.create(params)



'''

Tickets & Transactions

'''
# ? calculate route, then embed it on the ticket. 


# ? Write Transactions
#? For lunch box 1
alias Demo.Transactions.Transaction
txn =
  Transaction.changeset(%Transaction{
    abc_input: hong_entity.id,
    abc_output: tomi_clinic.id,
    abc_amount: invoice.total,
    items: [item.id],
  }) \
  |> Repo.insert!()

# ? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn, :invoice, invoice)


#? TICKETS ARE FOR TXN ONLY
ticket = Ecto.build_assoc(txn, :ticket, ticket)

#? preload if necessary.
preloaded_ticket = Repo.preload(ticket, [:transaction])


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