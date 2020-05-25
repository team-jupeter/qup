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
mr_musk = User.changeset(%User{}, %{name: "Ellen Musk", email: "mr_ellen_musk@000011.us"}) |> Repo.insert!

#? init taxations: kts = korea tax service, irs = internal revenue service
alias Demo.Taxations.Taxation

kts = Taxation.changeset(%Taxation{}, %{name: "Korea Tax Service", nation_id: korea.id}) |> Repo.insert!
irs = Taxation.changeset(%Taxation{}, %{name: "US Internal Revenue Service", nation_id: usa.id}) |> Repo.insert!


#? init entities
alias Demo.Entities.Entity

hong_entity = Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
tomi_entity = Entity.changeset(%Entity{}, %{name: "Sung Chunhyang Entity", email: "sung_chun_hyang@82345.kr"}) |> Repo.insert!
hankyung_gab = Entity.changeset(%Entity{}, %{name: "Hankyung GAB Branch", email: "hankyung_gab@3435.kr"}) |> Repo.insert!
tesla_entity = Entity.changeset(%Entity{}, %{name: "Tesla", email: "tesl@3435.us"}) |> Repo.insert!

#? build_assoc user and entity
Repo.preload(hong_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [mr_hong]) |> Repo.update!
Repo.preload(tomi_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [ms_sung]) |> Repo.update!
Repo.preload(hankyung_gab, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [gab]) |> Repo.update!
Repo.preload(tesla_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [mr_musk]) |> Repo.update!


#? make a GAB branch for Hangkyung Supul. Remember every supul has one, only one GAB branch.
hankyung_gab = Ecto.build_assoc(hankyung_supul, :entities, hankyung_gab) 

#? build_assoc hankyung_gab with korea
hankyung_gab = Ecto.build_assoc(korea, :entities, hankyung_gab) 
tesla_entity = Ecto.build_assoc(usa, :entities, tesla_entity) 

Repo.preload(hankyung_gab, [:nation, :supul])

#? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.BalanceSheet
alias Demo.Reports.GabBalanceSheet 

hankyung_gab_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: hankyung_gab.id}) |> Repo.insert!
hong_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id}) |> Repo.insert!
tomi_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_entity.id}) |> Repo.insert!
tesla_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: tesla_entity.id}) |> Repo.insert!

hankyung_gab_BS = Ecto.build_assoc(hankyung_gab_FR, :gab_balance_sheet, %GabBalanceSheet{monetary_unit: "KRW", t1: 9999990.00}) |> Repo.insert!
hong_entity_BS = Ecto.build_assoc(hong_entity_FR, :balance_sheet, %BalanceSheet{cash: 50000000.00}) |> Repo.insert!
tomi_entity_BS = Ecto.build_assoc(tomi_entity_FR, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
tesla_entity_BS = Ecto.build_assoc(tesla_entity_FR, :balance_sheet, %BalanceSheet{inventory: [%{model_y: 25}]}) |> Repo.insert!

'''
TRANSACTION 1

Transaction between hankyung_gab_entity and hong_entity.

The price of ABC T1, T2, T3 will be updated every second.
The code below is hard coded. We need write codes for invoice_items with only one item.
'''
alias Demo.Reports.Ledger
alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}


#? mr_hong needs ABC, so, let's write invoice for trade between mr_hong and hankyung_gab.
item = Item.changeset(%Item{}, %{gpc_code: "ABCDE21111", category: "Fiat Currency", name: "KRW", price: Decimal.from_float(0.001)}) |> Repo.insert!
invoice_items = [%{item_id: item.id, quantity: 20000}, %{item_id: item.id, quantity: 0}]


params = %{
  "buyer" => %{"entity_id" => hankyung_gab.id},
  "seller" => %{"entity_id" => hong_entity.id},
  "invoice_items" => invoice_items,
#   "output" => hong_public_address
}
{:ok, invoice} = Invoice.create(params)
invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

#? Write Transaction
txn_1 = Transaction.changeset(%Transaction{
    abc_input: hankyung_gab.id, 
    abc_output: hong_entity.id,
    }) |> Repo.insert!

item_quantity = Enum.at(invoice.invoice_items, 0).quantity
txn_1 = change(txn_1) \
    |> Ecto.Changeset.put_change(:abc_amount, invoice.total) \
    |> Ecto.Changeset.put_change(:items, [%{"KRW" => item_quantity}]) \
    |> Repo.update!


#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn_1, :invoice, invoice) 


#? Adjust balance_sheet of both.
#? Hankyung GAB
hankyung_gab_FR = Repo.preload(hankyung_gab, [financial_report: :gab_balance_sheet]).financial_report

hankyung_gab_BS = hankyung_gab_FR.gab_balance_sheet
hankyung_gab_BS = change(hankyung_gab_BS) |> \
    Ecto.Changeset.put_change(
        :cash, Decimal.add(hankyung_gab_BS.cash, Enum.at(txn_1.items, 0)["KRW"])) |>  \
    Ecto.Changeset.put_change(:t1, 
        Decimal.sub(hankyung_gab_BS.t1, txn_1.abc_amount)) |> Repo.update!

        

#? Hong Gil_Dong
alias Demo.ABC.T1

hong_entity_FR = Repo.preload(hong_entity, [financial_report: :balance_sheet]).financial_report

hong_entity_BS = hong_entity_FR.balance_sheet
hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_change(
        :cash, Decimal.sub(hong_entity_BS.cash,  Enum.at(txn_1.items, 0)["KRW"])) |> Repo.update!

t1s = [%T1{input: "gab dummy address", amount: txn_1.abc_amount, output: "hong dummy address"}]
hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!

 

'''
TRANSACTION 2
Transaction between Tesla and hong_entity
'''

#? CAR
alias Demo.Cars.Car

car_1 = Car.changeset(
    %Car{
        gpc_code: "ABCDE11133", category: "Standard SUV", 
        name: "Model Y", manufacturer: "Tesla", market_value: 5.0, 
        production_date: ~N[2020-05-24 06:14:09], 
        input: tesla_entity.id,
        output: tesla_entity.id,
        current_owner: tesla_entity.id, 
    }) |> Repo.insert!

#? write invoice for trade between mr_hong and hankyung_gab.
item_1 = Item.changeset(%Item{}, 
    %{
        product_uuid: car_1.id,
        price: car_1.market_value,
        current_owner: tesla_entity.id,
        new_owner: hong_entity.id,
        owner_history: [tesla_entity.id],
        txn_history: [],    
    }) |> Repo.insert!


invoice_items = [%{item_id: item_1.id, quantity: 1.0}, %{item_id: item_1.id, quantity: 0.0}]

params = %{
  "buyer" => %{"entity_id" => hong_entity.id, "entity_address" => "dummy hong address"},
  "seller" => %{"entity_id" => tesla_entity.id, "entity_address" => "dummy tesla address"},
  "invoice_items" => invoice_items,
}
{:ok, invoice} = Invoice.create(params)
invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

#? hash_of_invoice = hong_public_sha256 = :crypto.hash(:sha256, invoice)


'''

Invoicies are stored by entities and transactions are stored by supuls.

'''

#? Write Transaction 
# tesla_entity_preload = Repo.preload(tesla_entity, [financial_report: :balance_sheet])
# tesla_bs = tesla_entity_preload.financial_report.balance_sheet
# hong_entity_preload = Repo.preload(hong_entity, [financial_report: :balance_sheet])

txn_2 = Transaction.changeset(%Transaction{
    abc_input: hong_entity.id,
    abc_output: tesla_entity.id,
    abc_amount: invoice.total,
    }) |> Repo.insert!
    

#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn_2, :invoice, invoice) 

item_quantity = Enum.at(invoice.invoice_items, 0).quantity
txn_2 = change(txn_1) \
    |> Ecto.Changeset.put_change(:items, [%{model_y: item_quantity}]) \
    |> Repo.update!

# Repo.preload(txn_2, :invoice) #? why not the reverse???? how to konw invoice_id through txn_2 ???
Repo.preload(invoice, :transaction)


'''

Adjust balance_sheet of both.

''' 
#? Hong Gil_Dong
hong_t1s = hong_entity_BS.t1s

#? case 
#? Enum.at(hong_t1s, 0).output == hong_entity.id and
#? Enum.at(invoice.invoice_items, 0).output == tesla_entity.id
#? do:
residual_amount = Decimal.sub(Enum.at(hong_t1s, 0).amount, invoice.total)
[head | hong_t1s] = hong_t1s

t1s = [%T1{input: hong_entity.id, output: hong_entity.id, amount: residual_amount}]
fixed_assets = hong_entity_BS.fixed_assets

hong_entity_BS = change(hong_entity_BS) \
    |> Ecto.Changeset.put_embed(:t1s, t1s) \
    |> Ecto.Changeset.put_change(:fixed_assets, [%{model_y: item_quantity} | fixed_assets]) \
    |> Repo.update!
#? end
    
#? Tesla Entity
tesla_entity_FR = Repo.preload(tesla_entity, [financial_report: :balance_sheet]).financial_report
tesla_entity_BS = tesla_entity_FR.balance_sheet

t1s = [%T1{input: hong_entity.id, output: tesla_entity.id, amount: invoice.total}]

item_quantity = Decimal.to_integer(item_quantity)
updated_inventory = [Map.update(Enum.at(tesla_entity_BS.inventory, 0), :model_y, 0, &(&1 - item_quantity))]

#? code below is hard coded. Find out how to update a map's value in a list. 
tesla_entity_BS = change(hong_entity_BS) \
    |> Ecto.Changeset.put_embed(:t1s, t1s) \
    |> Ecto.Changeset.put_change(:inventory, updated_inventory) \
    |> Repo.update!

#? Change input and outp of the car sold to mr_hong
car_1 = Car.changeset(car_1, %{input: tesla_entity.id, output: hong_entity.id}) |> Repo.update!
car_1 = Car.owner_changeset(car_1, %{new_owner: hong_entity.id, recent_txn_id: txn_2.id}) |> Repo.update!
# end

 


'''
Authentication, Non-repudiation, Integrity

참고 Youtube => Blockchain tutorial 6: Digital signature
'''
#? Now supul, state_supul ...are entities with type fields.
#? Entity types: human(single or group), entity(object or concept), supul(supul, state_supul, nation_supul, global_supul)



'''

CRYPTO

'''
#? hankyung_gab_entity's private_key or signing key or secret key
#? openssl genrsa -out hankyung_gab_private_key.pem 2048
#? openssl rsa -in hankyung_gab_private_key.pem -pubout > hankyung_gab_public_key.pem
hankyung_gab_rsa_priv_key = ExPublicKey.load!("./hankyung_gab_private_key.pem")
hankyung_gab_rsa_pub_key = ExPublicKey.load!("./hankyung_gab_public_key.pem")

# hankyung_public_sha256 = :crypto.hash(:sha256, hankyung_gab_rsa_pub_key)

#? hankyung_gab_entity's private_key or signing key or secret key
#? openssl genrsa -out tesla_private_key.pem 2048
#? openssl rsa -in tesla_private_key.pem -pubout > tesla_public_key.pem
tesla_rsa_priv_key = ExPublicKey.load!("./tesla_private_key.pem")
tesla_rsa_pub_key = ExPublicKey.load!("./tesla_public_key.pem")


#? hong_entity's private_key or signing key or secret key
#? openssl genrsa -out hong_private_key.pem 2048
#? openssl rsa -in hong_private_key.pem -pubout > hong_public_key.pem
hong_rsa_priv_key = ExPublicKey.load!("./hong_private_key.pem")
hong_rsa_pub_key = ExPublicKey.load!("./hong_public_key.pem")


#? tomi_entity's private_key or signing key or secret key
#? openssl genrsa -out tomi_private_key.pem 2048
#? openssl rsa -in tomi_private_key.pem -pubout > tomi_public_key.pem
tomi_rsa_priv_key = ExPublicKey.load!("./tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./tomi_public_key.pem")




'''
Non-repudiation: Mulet of hankyung_gab
'''

'''
After receiving ABC from hankyung_gab, mr_hong makes a payload 
and send it to the mulet of hankyung_supul to record the transaction 
in the openhash blockchain. 
'''
#? 

'''
First, mr_hong makes the payload of txn_1, and send it to hankyung_supul's mulet.
'''
import Poison

# serialize the JSON
msg_serialized = Poison.encode!(txn_1)

# generate time-stamp
ts = DateTime.utc_now |> DateTime.to_unix

# add a time-stamp
ts_msg_serialized = "#{ts}|#{msg_serialized}"

# generate a secure hash using SHA256 and sign the message with the private key
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, hong_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64 signature}"


'''
Second, the hankyung_mulet verifies and unserialize the payload from mr_hong. 
'''
alias Demo.Mulets.Mulet
hankyung_mulet = Ecto.build_assoc(hankyung_supul, :mulet, %{current_hash: hankyung_supul.id}) 

# pretend transmit the message...
# pretend receive the message...

# break up the payload
parts = String.split(payload, "|")

#? reject the payload if the timestamp is newer than the arriving time to mulet. 
recv_ts = Enum.fetch!(parts, 0)


# pretend ensure the time-stamp is not too old (or from the future)...
#? it should probably no more than 5 minutes old, and no more than 15 minutes in the future

# verify the signature
recv_msg_serialized = Enum.fetch!(parts, 1)
{:ok, recv_sig} = Enum.fetch!(parts, 2) |> Base.url_decode64

{:ok, sig_valid} = ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig, hong_rsa_pub_key)
# assert(sig_valid)

recv_msg_unserialized = Poison.Parser.parse!(recv_msg_serialized, %{})
# assert(msg == recv_msg_unserialized)

'''
Third, the mulet of hankyung_supul openhashes the unserialized message. 
'''
alias Demo.Mulets.Mulet
hankyung_mulet = Ecto.build_assoc(hankyung_supul, :mulet, %{current_hash: hankyung_supul.id}) 

txn_hash = 
    :crypto.hash(:sha256, recv_msg_serialized) \
    |> Base.encode16() \
    |> String.downcase() 

hankyung_mulet = Mulet.changeset(hankyung_mulet, %{incoming_hash: txn_hash})

'''
Fourth, send the new hash to the mulets of upper supuls. 
'''
#? build_assoc jejudo_mulet with jejudo
jejudo_mulet = Ecto.build_assoc(jejudo_supul, :mulet, %{current_hash: jejudo_supul.id}) 

#? build_assoc korea_mulet with korea
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 

#? build_assoc global_mulet with global
global_mulet = Ecto.build_assoc(global_supul, :mulet, %{current_hash: global_supul.id}) 
    
#? send hankyung_mulet.current_hash to the jejudo_mulet
incoming_hash = hankyung_mulet.current_hash
jejudo_mulet = Mulet.changeset(jejudo_mulet, %{incoming_hash: incoming_hash})

#? korea_mulet
incoming_hash = jejudo_mulet.current_hash
korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: incoming_hash})

#? global_mulet
incoming_hash = jejudo_mulet.current_hash
global_mulet = Mulet.changeset(global_mulet, %{incoming_hash: incoming_hash})



