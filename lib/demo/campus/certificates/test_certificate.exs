import Ecto.Query
import Ecto.Changeset
alias Demo.Repo
use Timex

# ? init korea and seoul
alias Demo.Nations.Nation

korea = Nation.changeset(%Nation{}, %{name: "South Korea"}) |> Repo.insert!()

#? init supuls
alias Demo.NationSupuls.NationSupul
alias Demo.StateSupuls.StateSupul

korea_supul = NationSupul.changeset(%NationSupul{}, %{name: "Korea Supul", supul_code: 0x52000000}) |> Repo.insert!
seoul_supul = StateSupul.changeset(%StateSupul{}, %{name: "Seoul Supul", supul_code: 0x52000000}) |> Repo.insert!


# ? init users
alias Demo.Accounts.User
ms_sung =
  User.changeset(%User{}, %{name: "Sung Chunhyang", email: "sung_chun_hyang@82345.kr"}) \
  |> Repo.insert!()

korea =
  User.changeset(%User{}, %{name: "South Korea", email: "korea@000000.kr"}) |> Repo.insert!()


# ? init entities
alias Demo.Business.Entity

mohw =
  Entity.changeset(%Entity{}, %{name: "Ministry of Health and Welfare of South Korea", email: "mohw@0000.kr"}) |> Repo.insert!()

sung_entity =
  Entity.changeset(%Entity{}, %{name: "Sung Chun Hyang", email: "sung@3532.kr", entity_address: "제주시 한림읍 11-1"}) |> Repo.insert!()

tomi_clinic =
  Entity.changeset(%Entity{}, %{name: "Tomi Clinic", email: "tomi@3532.kr", entity_address: "서울시 도봉구 ...."}) |> Repo.insert!()

seoul =
  Entity.changeset(%Entity{}, %{name: "Seoul", email: "seoul@1111.kr"}) |> Repo.insert!()


Repo.preload(sung_entity, [:users])  \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:users, [ms_sung])  \
|> Repo.update!() 


'''

CRYPTO

'''
#? openssl genrsa -out mohw_private_key.pem 2048
#? openssl rsa -in mohw_private_key.pem -pubout > mohw_public_key.pem
mohw_rsa_priv_key = ExPublicKey.load!("./mohw_private_key.pem")
mohw_rsa_pub_key = ExPublicKey.load!("./mohw_public_key.pem")

sung_rsa_priv_key = ExPublicKey.load!("./sung_private_key.pem")
sung_rsa_pub_key = ExPublicKey.load!("./sung_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./tomi_public_key.pem")




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
transaction =
  Transaction.changeset(%Transaction{
    abc_input: sung_entity.id,
    abc_output: mohw.id,
    abc_amount: invoice.total,
    items: [certificate.id],
  }) \
  |> Repo.insert!()

# ? Association between Transaction and Invoice
invoice = Ecto.build_assoc(transaction, :invoice, invoice)
ticket = Ecto.build_assoc(transaction, :ticket, ticket)


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
residual_amount = Decimal.sub(Enum.at(sung_entity_BS.t1s, 0).amount, transaction.abc_amount)
new_t1s = [%T1{input: sung_entity.id, output: sung_entity.id, amount: residual_amount}]
sung_entity_BS = change(sung_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!

# ? mohw
new_t1s = [%T1{input: sung_entity.id, output: mohw_entity.id, amount: transaction.abc_amount} | mohw_entity_BS.t1s]
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



