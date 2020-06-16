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

hanlim_supul =
  Supul.changeset(%Supul{}, %{name: "Hanlim Supul", supul_code: 0x35434500}) \
  |> Repo.insert!()

# ? init users
alias Demo.Accounts.User

# {ok, mr_hong} = User.changeset(%User{}, %{name: "Hong Gildong"}) |> Repo.insert
mr_hong =
  User.changeset(%User{}, %{
    name: "Hong_Gildong", 
    username: "mr_hong", 
    email: "hong_gil_dong@82345.kr",
    type: "Human",
    ssn: "8010051898822kr",
    birth_date: ~N[1990-05-05 06:14:09],
    }) \
  |> Repo.insert!()
 
ms_sung =
  User.changeset(%User{}, %{
    name: "Sung_Chunhyang", 
    username: "ms_sung", 
    email: "sung_chun_hyang@82345.kr",
    type: "Human",
    ssn: "8345051898822kr",
    birth_date: ~N[2000-09-09 16:14:09],
    }) \
  |> Repo.insert!()

mr_lim =
  User.changeset(%User{}, %{
    name: "Lim_Geukjung", 
    username: "mr_lim", 
    email: "limgeukjung@88889.kr",
    type: "Human",
    ssn: "5410051898822kr",
    birth_date: ~N[1970-11-11 09:14:09],
    }) \
  |> Repo.insert!()

gab =
  User.changeset(%User{}, %{
    name: "GAB", 
    username: "gab", 
    email: "gab@000011.un",
    type: "Bank",
    founding_date: ~N[1990-05-24 06:14:09],
    }) \
  |> Repo.insert!()

korea =
  User.changeset(%User{}, %{
    type: "Nation",
    name: "South_Korea", 
    username: "korea", 
    email: "korea@000000.kr",
    }) |> Repo.insert!()
 

'''

CRYPTO
Both users and entities should have private and public keys for future transactions.
'''

# ? openssl genrsa -out korea_private_key.pem 2048
# ? openssl rsa -in korea_private_key.pem -pubout > korea_public_key.pem

lim_rsa_priv_key = ExPublicKey.load!("./keys/lim_private_key.pem")
lim_rsa_pub_key = ExPublicKey.load!("./keys/lim_public_key.pem")

hong_rsa_priv_key = ExPublicKey.load!("./keys/hong_private_key.pem")
hong_rsa_pub_key = ExPublicKey.load!("./keys/hong_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./keys/tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./keys/tomi_public_key.pem")

korea_rsa_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")
korea_rsa_pub_key = ExPublicKey.load!("./keys/korea_public_key.pem")
    

alias Demo.Repo
alias Demo.Accounts.User
for u <- Repo.all(User) do
  Repo.update!(User.registration_changeset(u, %{password: "temppass"}))
end

# ? init entities
alias Demo.Business.Entity

hong_entity =
  Entity.changeset(%Entity{}, %{
    name: "Hong Gildong Entity", 
    email: "hong_gil_dong@8245.kr", 
    entity_address: "제주시 한경면 20-1 해거름전망대",
    }) \
  |> Repo.insert!()

lim_entity =
  Entity.changeset(%Entity{}, %{
    name: "Lim Geuk Jung Entity", 
    email: "limgeukjung@88889@8245.kr", 
    entity_address: "서귀포시 안덕면 77-1",
    }) \
  |> Repo.insert!()

tomi_entity =
  Entity.changeset(%Entity{}, %{
    name: "Tomi Lunch Box", 
    email: "tomi@3532.kr", 
    entity_address: "제주시 한림읍 11-1",
    }) \
  |> Repo.insert!()

gopang =
  Entity.changeset(%Entity{}, %{
    name: "Gopang Hankyng", 
    email: "gopang_hankyung@3435.kr",
    }) |> Repo.insert!()

kts =
  Entity.changeset(%Entity{}, %{
    name: "Korea Tax Service", 
    email: "kts@1111.kr",
    }) |> Repo.insert!()



'''

CRYPTO
Both users and entities should have private and public keys for future transactions.
'''

# ? openssl genrsa -out kts_private_key.pem 2048
# ? openssl rsa -in kts_private_key.pem -pubout > kts_public_key.pem

hong_entity_rsa_priv_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
hong_entity_rsa_pub_key = ExPublicKey.load!("./keys/hong_entity_public_key.pem")

sung_entity_rsa_priv_key = ExPublicKey.load!("./keys/sung_entity_private_key.pem")
sung_entity_rsa_pub_key = ExPublicKey.load!("./keys/sung_entity_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./keys/tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./keys/tomi_public_key.pem")

lim_entity_rsa_priv_key = ExPublicKey.load!("./keys/lim_entity_private_key.pem")
lim_entity_rsa_pub_key = ExPublicKey.load!("./keys/lim_entity_public_key.pem")
    
kts_rsa_priv_key = ExPublicKey.load!("./keys/kts_private_key.pem")
kts_rsa_pub_key = ExPublicKey.load!("./keys/kts_public_key.pem")
    
# ? build_assoc user and entity
mr_hong = User.changeset_update_entities(mr_hong, hong_entity)
hong_entity = Entity.changeset_update_users(hong_entity, mr_hong)

User.changeset_update_entities(mr_lim, lim_entity)
Entity.changeset_update_users(lim_entity, mr_lim)

User.changeset_update_entities(ms_sung, [tomi_entity, sung_entity])
Entity.changeset_update_users(tomi_entity, ms_sung)
Entity.changeset_update_users(sung_entity, ms_sung)

User.changeset_update_entities(korea, [kts, gopang])
Entity.changeset_update_users(tomi_entity, korea)
Entity.changeset_update_users(sung_entity, korea)


# ? Generate private and public keys for entities
gopang_rsa_priv_key = ExPublicKey.load!("./keys/gopang_private_key.pem")
gopang_rsa_pub_key = ExPublicKey.load!("./keys/gopang_public_key.pem")

hong_entity_rsa_priv_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
hong_entity_rsa_pub_key = ExPublicKey.load!("./keys/hong_entity_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./keys/tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./keys/tomi_public_key.pem")

kts_rsa_priv_key = ExPublicKey.load!("./keys/kts_private_key.pem")
kts_rsa_pub_key = ExPublicKey.load!("./keys/kts_public_key.pem")





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
  Ecto.build_assoc(hong_entity, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]}) \
  |> Repo.insert!()

lim_entity_BS =
  Ecto.build_assoc(lim_entity, :balance_sheet, %BalanceSheet{
    cash: Decimal.from_float(50_000_000.00),
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]}) \
  |> Repo.insert!()

tomi_entity_BS =
  Ecto.build_assoc(tomi_entity, :balance_sheet, %BalanceSheet{
    fixed_assets: [%{building: 1.0}],
    t1s: [%{
      input: korea.id, 
      output: gopang.id, 
      amount: Decimal.from_float(10_000.00)}]
    }) \
  |> Repo.insert!()


'''

CERTIFICATE GRANT
보건복지부는 성춘향에게 전문의 자격증을 발급

'''
alias Demo.Documents.Document

 document = Document.changeset(
    %Document{
        title: "진단의학 전문의 자격증",
        presented_to: sung_entity.id,
        presented_by: [mohw.id],
        summary: "위와 같이 자격을....",
        attached_docs_list: ["졸업증명서.id", "의사_국가시험_합격증명서.id", "전학년_성적증명서.id"],
        attached_docs_hashes: ["졸업증명서_hash", "의사_국가시험_합격증명서_hash", "전학년_성적증명서_hash"],
        hash_of_attached_docs_hashes: "sha256(attached_docs_hashes)",
    }) |> Repo.insert!

alias Demo.Certificates.Certificate
certificate = Certificate.changeset(%Certificate{name: "Diagnostic medicine specialist", document: document.id, issued_to: sung_entity.id, issued_date: Timex.to_date({2015, 6, 24})}) |> Repo.insert!

 
'''

License GRANT
서울시 도봉구는 토미 클리닉을 관내 의료기관으로 등기

'''
 document = Document.changeset(
    %Document{
        title: "의료기관 등기",
        presented_to: tomi_clinic.id,
        presented_by: [seoul.id],
        summary: "위와 같이 ....",
        attached_docs_list: [],
        attached_docs_hashes: [],
        hash_of_attached_docs_hashes: "sha256(attached_docs_hashes)",
    }) |> Repo.insert!

alias Demo.Licenses.License
license = License.changeset(%License{name: "Tomi Clinic", document: document.id, issued_to: sung_entity.id, issued_date: Timex.to_date({2015, 6, 24})}) |> Repo.insert!



'''

TRANSACTION
성춘향은 보건복지부에 전문의 자격증 발급 수수료를 지불

'''
alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Tickets.Ticket

# ? write invoice for trade between mr_sung and mohw.
item = Item.changeset(%Item{}, %{product_uuid: certificate.id, price: Decimal.from_float(100.0),
document: document.id}) |> Repo.insert!()

# ? issue an ticket
ticket = Ticket.changeset(%Ticket{}, %{item_id: item.id}) |> Repo.insert!()


invoice_items = [
  %{item_id: item.id, quantity: 1.0, item_name: "Diagnostic Specialist Certificate"},
  %{item_id: item.id, quantity: 0.0}
]

params = %{
  "buyer" => %{"main" => sung_entity.id, "participants" => sung_entity.id},
  "seller" => %{"main" => mohw.id, "participants" => mohw.id},
  "invoice_items" => invoice_items
}

{:ok, invoice} = Invoice.create(params)

# invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

# ? hash_of_invoice = sung_public_sha256 = :crypto.hash(:sha256, invoice)




'''

Ticket
전문의 자격증 발급 사항을 보건복지부가 소속된 Korea Supul에 기록

'''
# ? calculate route, then embed it on the ticket. 


# ? Write Transaction p
alias Demo.Transactions.Transaction
txn =
  Transaction.changeset(%Transaction{
    abc_input: sung_entity.id,
    abc_output: mohw.id,
    abc_amount: invoice.total,
    items: [certificate.id],
  }) \
  |> Repo.insert!()

# ? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn, :invoice, invoice)
ticket = Ecto.build_assoc(txn, :ticket, ticket)


preloaded_ticket = Repo.preload(ticket, [:transaction])



'''

SIGNATURE
First, both buyer and seller sign the ticket.

'''
import Poison

# serialize the JSON
msg_serialized = Poison.encode!(preloaded_ticket)

# generate time-stamp
ts = DateTime.utc_now() |> DateTime.to_unix()

# add a time-stamp
ts_msg_serialized = "#{ts}|#{msg_serialized}"

# generate a secure hash using SHA256 and sign the message with the private key
{:ok, buyer_signature} = ExPublicKey.sign(ts_msg_serialized, sung_rsa_priv_key)
{:ok, seller_signature} = ExPublicKey.sign(ts_msg_serialized, mohw_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(buyer_signature)}|#{Base.url_encode64(seller_signature)}"

#? send the payload to the NEAREST common supul of both buyer and seller. 


'''

SUPUL
Second, the supul_mulet verifies and unserialize the payload from mr_sung. 

'''

alias Demo.Mulets.Mulet
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id})

#? pretend transmit the message...
#? pretend receive the message...

#? break up the payload
parts = String.split(payload, "|")

# ? reject the payload if the timestamp is newer than the arriving time to mulet. 
recv_ts = Enum.fetch!(parts, 0)

#? pretend ensure the time-stamp is not too old (or from the future)...
#? verify the signature
recv_msg_serialized = Enum.fetch!(parts, 1)
{:ok, recv_sig_buyer} = Enum.fetch!(parts, 2) |> Base.url_decode64()
{:ok, recv_sig_seller} = Enum.fetch!(parts, 3) |> Base.url_decode64()

{:ok, sig_valid_buyer} =
  ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_buyer, sung_rsa_pub_key)

{:ok, sig_valid_seller} =
  ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_seller, mohw_rsa_pub_key)

# assert(sig_valid)

#? Archieve Tickets
alias Demo.Mulets.TicketStorage
alias Demo.Tickets.Payload
payload_archive = Payload.changeset(%Payload{payload: payload}) |> Repo.insert!
payload_archive = Ecto.build_assoc(korea_supul, :payloads, payload_archive)

payload_storage = TicketStorage.changeset(%TicketStorage{}, %{new_payload: payload_archive})



#? recv_msg_unserialized = Poison.Parser.parse!(recv_msg_serialized, %{})
# assert(msg == recv_msg_unserialized)




'''

Adjust balance_sheet of both.
성춘향과 보건복지부의 BS를 업데이트

'''
alias Demo.ABC.T1

# ? mohw
new_t1s =
  Enum.map(mohw_BS.t1s, fn elem ->
    Map.update!(elem, :amount, fn curr_value -> Decimal.add(curr_value, ticket.mohw_fee) end)
  end)

mohw_BS = change(mohw_BS) |> Ecto.Changeset.put_change(:t1s, new_t1s) |> Repo.update!()


# ? mr_sung
residual_amount = Decimal.sub(Enum.at(sung_entity_BS.t1s, 0).amount, txn.abc_amount)
new_t1s = [%T1{input: sung_entity.id, output: sung_entity.id, amount: residual_amount}]
sung_entity_BS = change(sung_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!

# ? mohw
new_t1s = [%T1{input: sung_entity.id, output: mohw_entity.id, amount: txn.abc_amount} | mohw_entity_BS.t1s]
mohw_entity_BS = change(mohw_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!


'''

Third, the mulet of supul, state_supul, korea_supul and global_supul openhashes the unserialized message. 

'''

#? Supul Mulet 
#? pretend transmit the message...
#? pretend receive the message...
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 

incoming_hash = :crypto.hash(:sha256, payload) \
  |> Base.encode16() \
  |> String.downcase()
korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: incoming_hash})


#? send every 100th payload to the nation_supul of sate_supul.
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 
korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: incoming_hash})

#? send every 10000th payload to the global_supul of sate_supul.
global_mulet = Ecto.build_assoc(global_supul, :mulet, %{current_hash: global_supul.id}) 
global_mulet = Mulet.changeset(global_mulet, %{incoming_hash: incoming_hash})



