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
nonghyup = Entity.changeset(%Entity{}, %{name: "NongHyup Bank", email: "nonghyup_bank@3335.kr"}) |> Repo.insert!

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
#? hong_entity's private_key or signing key
hong_sk = 
    :crypto.strong_rand_bytes(16) \
    |> :base64.encode \
    |> :binary.decode_unsigned

#? hong_entity's public_key & public_address
hong_pk = :crypto.generate_key(:ecdh, :crypto.ec_curve(:secp256k1), hong_sk) \
    |> elem(0)
public_sha256 = :crypto.hash(:sha256, hong_pk)
public_ripemd160 = :crypto.hash(:ripemd160, public_sha256) 
hong_public_address = Demo.Crypto.Base58Check.encode(public_ripemd160, <<0x00>>)

#? seller == hankyung_gab 
#? hong_entity's private_key or signing key
hankyung_gab_sk = 
    :crypto.strong_rand_bytes(16) \
    |> :base64.encode \
    |> :binary.decode_unsigned

#? hong_entity's public_key & public_address
hankyung_gab_pk = :crypto.generate_key(:ecdh, :crypto.ec_curve(:secp256k1), hankyung_gab_sk) \
    |> elem(0)
public_sha256 = :crypto.hash(:sha256, hankyung_gab_pk)
public_ripemd160 = :crypto.hash(:ripemd160, public_sha256) 
hankyung_gab_public_address = Demo.Crypto.Base58Check.encode(public_ripemd160, <<0x00>>)

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

public_sha256 = :crypto.hash(:sha256, tomi_pk)
public_ripemd160 = :crypto.hash(:ripemd160, public_sha256) 
tomi_public_address = Demo.Crypto.Base58Check.encode(public_ripemd160, <<0x00>>)




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
item = Item.changeset(%Item{}, %{gpc_code: "ABCDE21111", category: "KRW", name: "1000", price: Decimal.from_float(0.12)}) |> Repo.insert!
invoice_items = [%{item_id: item.id, quantity: 2}, %{item_id: item.id, quantity: 0}]


params = %{
  "buyer" => %{"entity_id" => hankyung_gab.id, "entity_address" => hankyung_gab_public_address},
  "seller" => %{"entity_id" => hong_entity.id, "entity_address" => hong_public_address},
  "invoice_items" => invoice_items,
#   "output_to" => hong_public_address
}
{:ok, invoice} = Invoice.create(params)
invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

#? Write Transaction
txn = Transaction.changeset(%Transaction{
    input_from: hankyung_gab_public_address, 
    output_to: hong_public_address,
    output_amount: 0,
    locked: false,
    }) |> Repo.insert!

txn = change(txn) |> Ecto.Changeset.put_change(:output_amount, invoice.total) |> Repo.update!

#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn, :invoices, invoice) 


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
        Decimal.sub(hankyung_gab_BS.t1, txn.output_amount)) |> Repo.update!



#? Hong Gil_Dong
alias Demo.ABC.T1

hong_entity_FR = Repo.preload(hong_entity, [financial_report: :balance_sheet]).financial_report

hong_entity_BS = hong_entity_FR.balance_sheet
hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_change(
        :cash, Decimal.sub(hong_entity_BS.cash, Decimal.mult(String.to_integer(item.name), 
            Enum.at(invoice_items, 0).quantity))) |> Repo.update!

t1s = [%T1{input_from: hankyung_gab_public_address, amount: txn.output_amount, output_to: hong_public_address}]
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

#? Write Transaction
    
txn = Transaction.changeset(%Transaction{
    input_from: hankyung_gab_public_address, 
    output_to: hong_public_address,
    output_amount: 0,
    locked: false,
    locking_use_area: ["jejudo_supul"],
    locking_output_to_entity_catetory: ["food"],
    locking_output_to_specific_entities: [tomi_public_address]
    }) |> Repo.insert!

txn = change(txn) |> Ecto.Changeset.put_change(:output_amount, invoice.total) |> Repo.update!

#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn, :invoices, invoice) 

'''
Adjust balance_sheet of both.
''' 
#? Hong Gil_Dong
hong_entity_FR = Repo.preload(hong_entity, [financial_report: :balance_sheet]).financial_report

hong_entity_BS = hong_entity_FR.balance_sheet
hong_t1s = hong_entity_BS.t1s

case Enum.at(hong_t1s, 0).output_to == hong_public_address do:
    residual_amount = Decimal.sub(Enum.at(hong_t1s, 0).amount, invoice.total)
    [head | hong_t1s] = hong_t1s
    t1s = [%T1{input_from: hong_public_address, output_to: hong_public_address, amount: residual_amount}]
    
    hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!
    
    
    tomi_entity_FR = Repo.preload(tomi_entity, [financial_report: :balance_sheet]).financial_report
    tomi_entity_BS = tomi_entity_FR.balance_sheet
    
    t1s = [%T1{input_from: hong_public_address, output_to: tomi_public_address, amount: invoice.total}]
    
    hong_entity_BS = change(hong_entity_BS) |> \
        Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!
end

