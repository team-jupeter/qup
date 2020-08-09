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
korea_supul = Supul.changeset(%Supul{}, %{name: "moef_County", supul_code: 0x01434501}) |> Repo.insert!


#? init users
alias Demo.Accounts.User

# {ok, mr_hong} = User.changeset(%User{}, %{name: "Hong Gildong"}) |> Repo.insert
mr_hong = User.changeset(%User{}, %{name: "Hong Gildong", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
ms_sung = User.changeset(%User{}, %{name: "Sung Chunhyang", email: "sung_chun_hyang@82345.kr"}) |> Repo.insert!
gab = User.changeset(%User{}, %{name: "GAB: Global Autonomous Bank", email: "gab@000011.un"}) |> Repo.insert!
mr_musk = User.changeset(%User{}, %{name: "Ellen Musk", email: "mr_ellen_musk@000011.us"}) |> Repo.insert!
korea = User.changeset(%User{}, %{name: "South Korea", email: "korea@000000.kr"}) |> Repo.insert!


#? init entities
alias Demo.Entities.Entity

hong_entity = Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
tomi_entity = Entity.changeset(%Entity{}, %{name: "Sung Chunhyang Entity", email: "sung_chun_hyang@82345.kr"}) |> Repo.insert!
moef = Entity.changeset(%Entity{}, %{name: "moef Korea", email: "moef@3435.kr"}) |> Repo.insert!
tesla_entity = Entity.changeset(%Entity{}, %{name: "Tesla", email: "tesl@3435.us"}) |> Repo.insert!

#? build_assoc user and entity
Repo.preload(hong_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [mr_hong]) |> Repo.update!
Repo.preload(tomi_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [ms_sung]) |> Repo.update!
Repo.preload(moef, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [korea]) |> Repo.update!
Repo.preload(tesla_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [mr_musk]) |> Repo.update!


#? BinessEmbed
alias Demo.Accounts.BusinessEmbed

#? hard coded. In real codes, we will use user_id than user name, and product_id than product name.
tesla_korea  = [
    %BusinessEmbed{name: "Tesla Korea", crn: "AADFD3432", sic_code: "FAAF3432",
    legal_status: "Corporation", year_started: 2020, addresses: [%{office: "제주시 한경면 판포중1길 10-1 해거름전망대"}],
    employees: [%{CEO: "Ellen Musk"}, %{test_driver: "Son O_Gong"}], products: [%{car: "CyberTruck"}, %{car: "Model_S"}], 
    yearly_sales: Decimal.from_float(1523454.33), num_of_shares: [%{common_stock: 5000000}, %{preferred_stock: 1000000}],
    share_price: [%{common_stock: Decimal.from_float(435.34)}, %{preferred_stock: Decimal.from_float(111.34)}], accrued_tax_payment: Decimal.from_float(352425.34),
    credit_rate: "AAA"}
    ] #? List => an entity may have more than one businesses
   

tesla_entity = change(tesla_entity) \
    |> Ecto.Changeset.put_embed(:business_embeds, tesla_korea) \
    |> Repo.update!


#? make a GAB branch for Hangkyung Supul. Remember every supul has one, only one GAB branch.
# moef = Ecto.build_assoc(korea_supul, :entities, moef) 

#? build_assoc moef with korea
moef = Ecto.build_assoc(korea, :entities, moef) 
tesla_entity = Ecto.build_assoc(usa, :entities, tesla_entity) 

Repo.preload(moef, [:nation, :supul])

#? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.BalanceSheet
alias Demo.Reports.GabBalanceSheet 
alias Demo.Reports.GovBalanceSheet 

moef_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: moef.id}) |> Repo.insert!
hong_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id}) |> Repo.insert!
tomi_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: tomi_entity.id}) |> Repo.insert!
tesla_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: tesla_entity.id}) |> Repo.insert!

moef_BS = Ecto.build_assoc(moef_FR, :gov_balance_sheet, %GovBalanceSheet{monetary_unit: "KRW", ts: [%{input: korea.id, output: moef.id, amount: Decimal.from_float(10000000.00)}], cashes: [%{KRW: Decimal.new(10000000000.00)}]}) |> Repo.insert!
hong_entity_BS = Ecto.build_assoc(hong_entity_FR, :balance_sheet, %BalanceSheet{cash: Decimal.new(50000000.00)}) |> Repo.insert!
tomi_entity_BS = Ecto.build_assoc(tomi_entity_FR, :balance_sheet, %BalanceSheet{fixed_assets: [%{building: 1.0}]}) |> Repo.insert!
tesla_entity_BS = Ecto.build_assoc(tesla_entity_FR, :balance_sheet, %BalanceSheet{inventory: []}) |> Repo.insert!



'''

CRYPTO

'''

#? moef_entity's private_key or signing key or secret key
#? openssl genrsa -out moef_private_key.pem 2048
#? openssl rsa -in moef_private_key.pem -pubout > moef_public_key.pem
moef_rsa_priv_key = ExPublicKey.load!("./moef_private_key.pem")
moef_rsa_pub_key = ExPublicKey.load!("./moef_public_key.pem")

# moef_public_sha256 = :crypto.hash(:sha256, moef_rsa_pub_key)

#? moef_entity's private_key or signing key or secret key
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



#? Write a document on policy financing projects
alias Demo.Documents.Document

 document = Document.changeset(
    %Document{
        title: "국가연구개발사업 신청서",
        presented_to: moef.id,
        presented_by: [tesla_entity.id, tomi_entity.id],
        summary: "이모의 고단한 손길없이 자율 동작하는 김밥말이 머신을 개발하여....",
        attached_docs_list: ["사업계획서.id", "참여연구원_목록.id", "연구자금_집행계획서.id"],
        attached_docs_hashes: ["사업계획서_hash", "참여연구원_목록_hash", "연구자금_집행계획서_hash"],
        hash_of_attached_docs_hashes: "sha256(attached_docs_hashes)",
    }) |> Repo.insert!

    '''
    #? For example, the document below is expected to be hashed and attached to the document above.
    
    참여연구원_목록 = Document0034.changeset(
    %Document{
        title: "참여연구원 명단 및 약력",
        content: "손오공: 화과산에서 10년간 도를 닦고...,홍길동, 임꺽정, X-man",
    }) |> Repo.insert!
    '''

#? Write a subject on policy financing projects
alias Demo.MOEFs.RnDProject

 rnd_project = RnDProject.changeset(
    %RnDProject{
        category: "국가 R&D 사업",
        starting_date: ~N[2020-05-24 06:14:09],
        ending_date:  ~N[2020-06-24 06:14:09],
        interest_rate: Decimal.from_float(2.5),
        self_funding_ratio: Decimal.from_float(30.0),
        applicants: [tesla_entity.id, tomi_entity.id], 
        documents: [document.id],
    }) |> Repo.insert!


'''

TRANSACTION
Let's assume Tesla is selected as beneficiary of policy finance.
Transaction between moef and tesla_entity.

'''
alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}

#? write invoice for trade between mr_hong and moef.
item = Item.changeset(%Item{}, 
    %{
        product_uuid: rnd_project.id,
        price: Decimal.from_float(1000000.0),
        document: document.id
    }) |> Repo.insert!


invoice_items = [%{item_id: item.id, quantity: 1.0, item_name: "국가 RnD 사업"}, %{item_id: item.id, quantity: 0.0}]

params = %{
  "buyer" => %{"main" => moef.id, "participants" => moef.id},
  "seller" => %{"main" => tesla_entity.id, "participants" => tomi_entity.id},
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

transaction = Transaction.changeset(%Transaction{
    abc_input: moef.id,
    abc_output: tesla_entity.id,
    t1_amount: invoice.total,
    items: [%{report: "final_report"}]
    }) |> Repo.insert!
    

#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(transaction, :invoice, invoice) 

'''

Adjust balance_sheet of both.

''' 

#? moef
alias Demo.ABC.T1

#? Adjust balance_sheet of both.
#? moef
#? The code below NOT consider any other elements in the ts list. We should find out just enough elements to pay the invoice total. 
new_ts = Enum.map(moef_BS.t1s, fn elem ->
    Map.update!(elem, :amount, fn curr_value -> Decimal.sub(curr_value, transaction.t1_amount) end)
end)

moef_BS = change(moef_BS) |> \
    Ecto.Changeset.put_change(:ts, new_t1s) \
    |> Repo.update!

#? Tesla Korea
t1s = [%T1{
    input: "moef_public_address", 
    amount: transaction.t1_amount, 
    output: "moef_public_address",
    locked: true, 
    locking_use_until: "2015-01-23 23:50:07",
    locking_output_entity_catetory: ["Computer and related machinery", "Softwares"],
    locking_output_specific_entities: ["LG Electronics"],
    locking_output_specific_dates: [
        %{to_whom: hong_entity.id, 
        when: ["2015-01-23 23:50:07", "2015-01-23 23:50:07"], 
        how_much: Decimal.from_float(500.00),
        why: "수석 연구원"},
        %{to_whom: tomi_entity.id, 
        when: ["2015-01-23 23:50:07", "2015-01-23 23:50:07"], 
        how_much: Decimal.from_float(1000.00),
        why: "e-Commerce module 코딩"}]
}]

tesla_entity_BS = change(tesla_entity_BS) |> \
    Ecto.Changeset.put_embed(:t1s, t1s) |> Repo.update!



'''
Non-repudiation: Mulet of moef
'''

'''
After receiving ABC from moef, mr_hong makes a payload 
and send it to the mulet of korea_supul to record the transaction 
in the openhash blockchain. 
'''
#? 

'''
First, mr_hong makes the payload of transaction, and send it to korea_supul's mulet.
'''
import Poison

# serialize the JSON
msg_serialized = Poison.encode!(transaction)

# generate time-stamp
ts = DateTime.utc_now |> DateTime.to_unix

# add a time-stamp
ts_msg_serialized = "#{ts}|#{msg_serialized}"

# generate a secure hash using SHA256 and sign the message with the private key
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, tesla_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64 signature}"


'''
Second, the moef_mulet verifies and unserialize the payload from mr_hong. 
'''
alias Demo.Mulets.Mulet
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 

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

{:ok, sig_valid} = ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig, tesla_rsa_pub_key)
# assert(sig_valid)

recv_msg_unserialized = Poison.Parser.parse!(recv_msg_serialized, %{})
# assert(msg == recv_msg_unserialized)

'''
Third, the mulet of korea_supul openhashes the unserialized message. 
'''
transaction_hash = 
    :crypto.hash(:sha256, recv_msg_serialized) \
    |> Base.encode16() \
    |> String.downcase() 

korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: transaction_hash})

'''
Fourth, send the new hash to the mulets of upper supuls. 
'''
#? global_mulet
incoming_hash = korea_mulet.current_hash
global_mulet = Mulet.changeset(global_mulet, %{incoming_hash: incoming_hash})




alias Demo.MOEFs.MOEF



moef = Repo.insert! MOEF.changeset(%MOEF{}, %{settings: %{columns: %{"key" => "value", "key2" => "value2"}}})

settings_changeset = moef.settings \
    |> Ecto.Changeset.change(%{columns: %{moef.settings.columns | "key" => "new value"}})

changeset = moef \
    |> Ecto.Changeset.change \
    |> Ecto.Changeset.put_embed(:settings, settings_changeset) \
    |> Repo.update!

assert Repo.one(Moef).settings.columns == %{"key" => "new value", "key2" => "value2"}
