import Ecto.Query
import Ecto.Changeset
alias Demo.Repo

#? init nations
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!
usa = Nation.changeset(%Nation{}, %{name: "USA"}) |> Repo.insert!


#? init supuls. For example, Korea will have about 5,000 supuls.
alias Demo.GlobalSupuls.GlobalSupul
alias Demo.NationSupuls.NationSupul
alias Demo.StateSupuls.StateSupul
alias Demo.Supuls.Supul

global_supul = GlobalSupul.changeset(%GlobalSupul{}, %{name: "Global Supul", supul_code: 0x00000000}) |> Repo.insert!
korea_supul = NationSupul.changeset(%NationSupul{}, %{name: "Korea Supul", supul_code: 0x52000000}) |> Repo.insert!
jejudo_supul = StateSupul.changeset(%StateSupul{}, %{name: "Jejudo State Supul", supul_code: 0x01434500}) |> Repo.insert!
hankyung_supul = Supul.changeset(%Supul{}, %{name: "Hankyung_County", supul_code: 0x01434501}) |> Repo.insert!


#? init users
alias Demo.Accounts.User

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

hankyung_gab_BS = Ecto.build_assoc(hankyung_gab_FR, :gab_change_sheet, %GabBalanceSheet{monetary_unit: "KRW", ts: [%{hankyung: Decimal.new(1000.00)}], cashes: [%{KRW: Decimal.new(1000000.00)}]}) |> Repo.insert!
hong_entity_BS = Ecto.build_assoc(hong_entity_FR, :balance_sheet, %BalanceSheet{cash: Decimal.new(50000000.00)}) |> Repo.insert!
tomi_entity_BS = Ecto.build_assoc(tomi_entity_FR, :balance_sheet, %BalanceSheet{fixed_assets: [%{building: 1.0}]}) |> Repo.insert!
tesla_entity_BS = Ecto.build_assoc(tesla_entity_FR, :balance_sheet, %BalanceSheet{inventory: []}) |> Repo.insert!
 


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
invoice_items = [%{item_id: item.id, item_name: :KRW, quantity: 20000}, %{item_id: item.id, quantity: 0}]


params = %{
  "buyer" => %{"entity_id" => hankyung_gab.id, "public_address" => "hankyung_gab_public_address"},
  "seller" => %{"entity_id" => hong_entity.id, "public_address" => "hong_public_address"},
  "invoice_items" => invoice_items,
#   "output" => hong_public_address
}
{:ok, invoice} = Invoice.create(params)
invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!


#? Write Transaction
item_quantity = Enum.at(invoice.invoice_items, 0).quantity
item_name = Enum.at(invoice.invoice_items, 0).item_name

transaction_1 = Transaction.changeset(%Transaction{
    #? we don't use name field because only the system see the transaction data, not humans.
    buyer: hankyung_gab.id, 
    seller: hong_entity.id,
    abc_input: "hankyung_gab_public_address", 
    abc_output: "hong_public_address",
    t1_amount: invoice.total,
    abc_input_ts: hankyung_gab_BS.t1s,
    if_only_item: item.id,
    fiat_currency: item_quantity,
    }) |> Repo.insert!

transaction_1 = change(transaction_1) \
    |> Ecto.Changeset.put_change(:t1_amount, invoice.total) \
    |> Repo.update!


#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(transaction_1, :invoice, invoice) 


#? Adjust balance_sheet of both.
#? Hankyung GAB
# hankyung_gab_FR = Repo.preload(hankyung_gab, [financial_report: :gab_change_sheet]).financial_report
# hankyung_gab_BS = hankyung_gab_FR.gab_change_sheet


new_t1s = Enum.map(hankyung_gab_BS.t1s, fn elem ->
    Map.update!(elem, :hankyung, fn curr_value -> Decimal.sub(curr_value, transaction_1.t1_amount) end)
end)
#? alternatively, we can use code below
# new_maps = Enum.map(hankyung_gab_BS.t1s, fn elem ->
#     Map.update!(elem, :hankyung, &(Decimal.sub(&1, transaction_1.t1_amount)))
#     end)
#? or below
# t1s_hankyung = Enum.at(hankyung_gab_BS.t1s, 0)
# t1s_hankyung = Map.update(t1s_hankyung, :hankyung, 0, &(Decimal.sub(&1, transaction_1.t1_amount)))

new_cashes = Enum.map(hankyung_gab_BS.cashes, fn elem ->
    Map.update!(elem, :KRW, fn curr_value -> Decimal.add(curr_value, transaction_1.fiat_currency) end)
end)

hankyung_gab_BS = change(hankyung_gab_BS) |> \
    Ecto.Changeset.put_change(:cashes, new_cashes) |>  \
    Ecto.Changeset.put_change(:t1s, new_t1s) \
    |> Repo.update!
 
        
#? Hong Gil_Dong
alias Demo.ABC.OpenT1
# hong_entity_FR = Repo.preload(hong_entity, [financial_report: :balance_sheet]).financial_report
# hong_entity_BS = hong_entity_FR.balance_sheet

hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_change(
        :cash, Decimal.sub(hong_entity_BS.cash, transaction_1.fiat_currency)) |> Repo.update!

t1s = [%OpenT1{input: "hankyung_gab_public_address", amount: transaction_1.t1_amount, output: "hong_public_address"}]
hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!


'''
TRANSACTION 2
Transaction between Tesla and hong_entity
'''

#? real_estate
alias Demo.RealEstates.RealEstate

해거름전망대 = RealEstate.changeset(
    %RealEstate{
        gpc_code: "ABCDE11100", category: "Commercial Residential Building", 
        address: "제주도 제주시 한경면 10-1 해거름전망대", 
        book_value: 14.0,
        market_value: 15.0, 
        input: tomi_entity.id,
        output: tomi_entity.id,
        current_owner: tomi_entity.id, 
    }) |> Repo.insert!

#? write invoice for trade between mr_hong and hankyung_gab.
item_1 = Item.changeset(%Item{}, 
    %{
        product_uuid: 해거름전망대.id,
        price: 해거름전망대.market_value,  
    }) |> Repo.insert!


invoice_items = [%{item_id: item_1.id, quantity: 1.0, item_name: "Residential Building"}, %{item_id: item_1.id, quantity: 0.0}]

params = %{
    
  "buyer" => %{"entity_id" => tesla_entity.id,  "public_address" => "tesla_public_address"},
  "seller" => %{"entity_id" => tomi_entity.id, "public_address" => "tomi_public_address"},
  "invoice_items" => invoice_items,
}
{:ok, invoice} = Invoice.create(params)
# invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

#? hash_of_invoice = hong_public_sha256 = :crypto.hash(:sha256, invoice)


'''

Invoicies are stored by entities and transactions are stored by supuls.

'''

#? Write Transaction 
# tesla_entity_preload = Repo.preload(tesla_entity, [financial_report: :balance_sheet])
# tesla_bs = tesla_entity_preload.financial_report.balance_sheet
# hong_entity_preload = Repo.preload(hong_entity, [financial_report: :balance_sheet])

transaction_2 = Transaction.changeset(%Transaction{
    abc_input: tesla_entity.id,
    abc_output: tomi_entity.id,
    t1_amount: invoice.total,
    }) |> Repo.insert!
    

#? Association between Transaction and Invoice
invoice_2 = Ecto.build_assoc(transaction_2, :invoice, invoice) 

item_quantity = Enum.at(invoice_2.invoice_items, 0).quantity
transaction_2 = change(transaction_2) \
    |> Ecto.Changeset.put_change(:items, [%{building: item_quantity}]) \
    |> Repo.update!

# Repo.preload(transaction_2, :invoice) #? why not the reverse???? how to konw invoice_id through transaction_2 ???
# Repo.preload(invoice_2, :transaction)


'''

Adjust balance_sheet of both.

''' 
#? Tesla
t1s = [%OpenT1{input: hankyung_gab.id, output: tesla_entity.id, amount: Decimal.from_float(10000.0)}]
tesla_entity_BS = change(tesla_entity_BS) |> Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!
tesla_t1s = tesla_entity_BS.t1s

#? case 
#? Enum.at(tesla_t1s, 0).output == tesla_entity.id and
#? Enum.at(invoice.invoice_items, 0).output == tesla_entity.id
#? do:
residual_amount = Decimal.sub(Enum.at(tesla_t1s, 0).amount, invoice.total)
# [head | tesla_t1s] = tesla_t1s
alias Demo.ABC.OpenT2
fixed_assets = tesla_entity_BS.fixed_assets
t1s = [%OpenT1{input: hankyung_gab.id, output: tesla_entity.id, amount: Decimal.from_float(10000.0)}]

tesla_entity_BS = change(tesla_entity_BS) \
    |> Ecto.Changeset.put_embed(:t1s, t1s) \
    |> Ecto.Changeset.put_change(:fixed_assets, [%{building: item_quantity} | fixed_assets]) \
    |> Repo.update!
#? end
    
#? Tomi Entity
# tomi_entity_FR = Repo.preload(tomi_entity, [financial_report: :balance_sheet]).financial_report
# tomi_entity_BS = tomi_entity_FR.balance_sheet

t1s = [%OpenT1{input: tesla_entity.id, output: tomi_entity.id, amount: invoice.total}]
item_quantity = Decimal.to_integer(item_quantity)
[head | updated_fixed_assets] = tomi_entity_BS.fixed_assets

#? code below is hard coded. Find out how to update a map's value in a list. 
tomi_entity_BS = change(tomi_entity_BS) \
    |> Ecto.Changeset.put_embed(:t1s, t1s) \
    |> Ecto.Changeset.put_change(:fixed_assets, updated_fixed_assets) \
    |> Repo.update!




#? Change input and outp of the real_estate sold to tesla
해거름전망대 = RealEstate.changeset(해거름전망대, %{input: tomi_entity.id, output: tesla_entity.id}) |> Repo.update!
해거름전망대 = RealEstate.owner_changeset(해거름전망대, %{new_owner: tesla_entity.id, recent_transaction_id: transaction_2.id}) |> Repo.update!
# end

 



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
First, mr_hong makes the payload of transaction_1, and send it to hankyung_supul's mulet.
'''
import Poison

# serialize the JSON
msg_serialized = Poison.encode!(transaction_1)

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

transaction_hash = 
    :crypto.hash(:sha256, recv_msg_serialized) \
    |> Base.encode16() \
    |> String.downcase() 

hankyung_mulet = Mulet.changeset(hankyung_mulet, %{incoming_hash: transaction_hash})

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



 