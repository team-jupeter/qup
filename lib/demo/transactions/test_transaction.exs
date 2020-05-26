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

#? init taxations: kts = korea tax service, irs = internal revenue service
alias Demo.Taxations.Taxation

kts = Taxation.changeset(%Taxation{}, %{name: "Korea Tax Service", nation_id: korea.id}) |> Repo.insert!
irs = Taxation.changeset(%Taxation{}, %{name: "US Internal Revenue Service", nation_id: usa.id}) |> Repo.insert!


#? init entities
alias Demo.Entities.Entity

hong_entity = Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
tomi_entity = Entity.changeset(%Entity{}, %{name: "Sung Chunhyang Entity", email: "sung_chun_hyang@82345.kr"}) |> Repo.insert!
hankyung_gab = Entity.changeset(%Entity{}, %{name: "Hankyung GAB Branch", email: "hankyung_gab@3435.kr"}) |> Repo.insert!

#? build_assoc user and entity
Repo.preload(hong_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [mr_hong]) |> Repo.update!
Repo.preload(tomi_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [ms_sung]) |> Repo.update!
Repo.preload(hankyung_gab, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [gab]) |> Repo.update!


#? make a GAB branch for Hangkyung Supul. Remember every supul has one, only one GAB branch.
hankyung_gab = Ecto.build_assoc(hankyung_supul, :entities, hankyung_gab) 

#? build_assoc hankyung_gab with korea
hankyung_gab = Ecto.build_assoc(korea, :entities, hankyung_gab) 

Repo.preload(hankyung_gab, [:nation, :supul])

#? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.BalanceSheet
alias Demo.Reports.GabBalanceSheet 

hankyung_gab_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: hankyung_gab.id}) |> Repo.insert!
hong_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id}) |> Repo.insert!
tomi_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_entity.id}) |> Repo.insert!

hankyung_gab_BS = Ecto.build_assoc(hankyung_gab_FR, :gab_balance_sheet, %GabBalanceSheet{monetary_unit: "KRW"}) |> Repo.insert!
hong_entity_BS = Ecto.build_assoc(hong_entity_FR, :balance_sheet, %BalanceSheet{}) |> Repo.insert!
tomi_entity_BS = Ecto.build_assoc(tomi_entity_FR, :balance_sheet, %BalanceSheet{}) |> Repo.insert!


'''
Authentication, Non-repudiation, Integrity

참고 Youtube => Blockchain tutorial 6: Digital signature
'''
#? Now supul, state_supul ...are entities with type fields.
#? Entity types: human(single or group), entity(object or concept), supul(supul, state_supul, nation_supul, global_supul)

#? crypto
# http://www.petecorey.com/blog/2018/01/22/generating-bitcoin-private-keys-and-public-addresses-with-elixir/

#? Buyer == hong_entity 
#? hong_entity's private_key or signing key or secret key
hong_sk = 
    :crypto.strong_rand_bytes(16) \
    |> :base64.encode \
    |> :binary.decode_unsigned

#? hong_entity's public_key & public_address
hong_pk = :crypto.generate_key(:ecdh, :crypto.ec_curve(:secp256k1), hong_sk) \
    |> elem(0)
hong_public_sha256 = :crypto.hash(:sha256, hong_pk)
hong_public_ripemd160 = :crypto.hash(:ripemd160, hong_public_sha256) 
hong_public_address = Demo.Crypto.Base58Check.encode(hong_public_ripemd160, <<0x00>>)

#? seller == hankyung_gab 
#? hong_entity's private_key or signing key
hankyung_gab_sk = 
    :crypto.strong_rand_bytes(16) \
    |> :base64.encode \
    |> :binary.decode_unsigned
 
#? hong_entity's public_key & public_address
hankyung_gab_pk = :crypto.generate_key(:ecdh, :crypto.ec_curve(:secp256k1), hankyung_gab_sk) \
    |> elem(0)
hankyung_public_sha256 = :crypto.hash(:sha256, hankyung_gab_pk)
hankyung_public_ripemd160 = :crypto.hash(:ripemd160, hankyung_public_sha256) 
hankyung_gab_public_address = Demo.Crypto.Base58Check.encode(hankyung_public_ripemd160, <<0x00>>)

#? Seller == tomi_entity
#? tomi_entity's private_key
#? signing_key or sk
tomi_sk = 
    :crypto.strong_rand_bytes(16) \
    |> :base64.encode \
    |> :binary.decode_unsigned

#? tomi_entity's public_key & public_address
#? verification key or vk
tomi_pk = :crypto.generate_key(:ecdh, :crypto.ec_curve(:secp256k1), tomi_sk) \
    |> elem(0)

tomi_public_sha256 = :crypto.hash(:sha256, tomi_pk)
tomi_public_ripemd160 = :crypto.hash(:ripemd160, tomi_public_sha256) 




'''
TRANSACTION 1

Transaction between hankyung_gab_entity and hong_entity.

The price of ABC T1, T2, T3 will be updated every second.
The code below is hard coded. We need write codes for invoice_items with only one item.
'''
alias Demo.Reports.Ledger
alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}


#? write invoice for trade between mr_hong and hankyung_gab.
item = Item.changeset(%Item{}, %{gpc_code: "ABCDE21111", category: "Fiat Currency", name: "KRW", price: Decimal.from_float(0.0012)}) |> Repo.insert!
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
    abc_output_amount: 0,
    
    item_input: hong_entity.id, 
    item_output: hankyung_gab.id,
    item_output_quantity: 0,

    locked: false,
    }) |> Repo.insert!

txn_1 = change(txn_1) \
    |> Ecto.Changeset.put_change(:abc_output_amount, invoice.total) \
    |> Ecto.Changeset.put_change(:item_output_quantity, invoice.total) \
    |> Ecto.Changeset.put_change(:abc_output_amount, invoice.total) \
    |> Repo.update!

#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn_1, :invoice, invoice) 


'''
ISSUE:: ledger sometimes does and sometimes doesn't load its children and grand children. why???
A child may preload its parent, but not the reverse. 

Repo.preload(txn, :invoices)
Repo.preload(invoice, :transaction)
''' 

#? Adjust balance_sheet of both.
#? Hankyung GAB
hankyung_gab_FR = Repo.preload(hankyung_gab, [financial_report: :gab_balance_sheet]).financial_report

hankyung_gab_BS = hankyung_gab_FR.gab_balance_sheet
hankyung_gab_BS = change(hankyung_gab_BS) |> \
    Ecto.Changeset.put_change(
        :cash, Decimal.add(hankyung_gab_BS.cash, Decimal.mult(String.to_integer(item.name), 
            Enum.at(invoice_items, 0).quantity))) |>  \
    Ecto.Changeset.put_change(:t1, 
        Decimal.sub(hankyung_gab_BS.t1, txn_1.output_amount)) |> Repo.update!



#? Hong Gil_Dong
alias Demo.ABC.T1

hong_entity_FR = Repo.preload(hong_entity, [financial_report: :balance_sheet]).financial_report

hong_entity_BS = hong_entity_FR.balance_sheet
hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_change(
        :cash, Decimal.sub(hong_entity_BS.cash, Decimal.mult(String.to_integer(item.name), 
            Enum.at(invoice_items, 0).quantity))) |> Repo.update!

t1s = [%T1{input: hankyung_gab_public_address, amount: txn_1.output_amount, output: hong_public_address}]
hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!

 

'''
TRANSACTION 2
Transaction between hong_entity and tomi_entity
'''

#? write invoice for trade between mr_hong and hankyung_gab.
item_1 = Item.changeset(%Item{}, %{gpc_code: "ABCDE11133", category: "Food", name: "김밥", price: Decimal.from_float(0.01)}) |> Repo.insert!
item_2 = Item.changeset(%Item{}, %{gpc_code: "ABCDE11134", category: "Food", name: "떡볶이", price: Decimal.from_float(0.02)}) |> Repo.insert!
invoice_items = [%{item_id: item_1.id, quantity: 3}, %{item_id: item_2.id, quantity: 3}]


params = %{
  "buyer" => %{"entity_id" => hong_entity.id, "entity_address" => hong_public_address},
  "seller" => %{"entity_id" => tomi_entity.id, "entity_address" => tomi_public_address},
  "invoice_items" => invoice_items,
}
{:ok, invoice} = Invoice.create(params)
invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!
#? hash_of_invoice = hong_public_sha256 = :crypto.hash(:sha256, invoice)








#? Write Transaction 
txn_2 = Transaction.changeset(%Transaction{
    hash_of_invoice: "dummy_hash_of_invoice",
    input: hankyung_gab_public_address, 
    output: hong_public_address,
    output_amount: 0,
    locked: false,
    locking_use_area: ["jejudo_supul"],
    locking_output_entity_catetory: ["food"],
    locking_output_specific_entities: [tomi_public_address]
    }) |> Repo.insert!

txn_2 = change(txn_2) |> Ecto.Changeset.put_change(:output_amount, invoice.total) |> Repo.update!

#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn_2, :invoice, invoice) 

'''
Adjust balance_sheet of both.
''' 
#? Hong Gil_Dong
hong_entity_FR = Repo.preload(hong_entity, [financial_report: :balance_sheet]).financial_report

hong_entity_BS = hong_entity_FR.balance_sheet
hong_t1s = hong_entity_BS.t1s

# case Enum.at(hong_t1s, 0).output == hong_public_address do:
    residual_amount = Decimal.sub(Enum.at(hong_t1s, 0).amount, invoice.total)
    [head | hong_t1s] = hong_t1s
    t1s = [%T1{input: hong_public_address, output: hong_public_address, amount: residual_amount}]
    
    hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!
    
    
    tomi_entity_FR = Repo.preload(tomi_entity, [financial_report: :balance_sheet]).financial_report
    tomi_entity_BS = tomi_entity_FR.balance_sheet
    
    t1s = [%T1{input: hong_public_address, output: tomi_public_address, amount: invoice.total}]
    
    hong_entity_BS = change(hong_entity_BS) |> \
        Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!
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
First, mr_hong makes the payload of txn_1, and send it to hankyung_supul's mulet.
'''
import Poison
#? openssl genrsa -out private_key.pem 2048
#? openssl rsa -in private_key.pem -pubout > public_key.pem

rsa_priv_key = ExPublicKey.load!("./private_key.pem")
rsa_pub_key = ExPublicKey.load!("./public_key.pem")

# serialize the JSON
msg_serialized = Poison.encode!(txn_1)

# generate time-stamp
ts = DateTime.utc_now |> DateTime.to_unix

# add a time-stamp
ts_msg_serialized = "#{ts}|#{msg_serialized}"

# generate a secure hash using SHA256 and sign the message with the private key
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, rsa_priv_key)

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

{:ok, sig_valid} = ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig, rsa_pub_key)
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



