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
korea_supul = Supul.changeset(%Supul{}, %{name: "kipo_County", supul_code: 0x01434501}) |> Repo.insert!


#? init users
alias Demo.Accounts.User

# {ok, mr_hong} = User.changeset(%User{}, %{name: "Hong Gildong"}) |> Repo.insert
mr_hong = User.changeset(%User{}, %{name: "Hong Gildong", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
gab = User.changeset(%User{}, %{name: "GAB: Global Autonomous Bank", email: "gab@000011.un"}) |> Repo.insert!
korea = User.changeset(%User{}, %{name: "South Korea", email: "korea@000000.kr"}) |> Repo.insert!


#? init entities
alias Demo.Accounts.Entity

hong_entity = Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@82345.kr"}) |> Repo.insert!
kipo = Entity.changeset(%Entity{}, %{name: "Korean Intellectual Property Office", email: "kipo@3435.kr"}) |> Repo.insert!

#? build_assoc user and entity
Repo.preload(hong_entity, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [mr_hong]) |> Repo.update!
Repo.preload(kipo, [:users]) |> Ecto.Changeset.change() |> Ecto.Changeset.put_assoc(:users, [korea]) |> Repo.update!



#? make a GAB branch for Hangkyung Supul. Remember every supul has one, only one GAB branch.
# kipo = Ecto.build_assoc(korea_supul, :entities, kipo) 

#? build_assoc kipo with korea
kipo = Ecto.build_assoc(korea, :entities, kipo) 

Repo.preload(kipo, [:nation, :supul])

#? prepare financial statements for entities.
alias Demo.Reports.FinancialReport
alias Demo.Reports.BalanceSheet
alias Demo.Reports.GabBalanceSheet 
alias Demo.Reports.GovBalanceSheet 

kipo_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: kipo.id}) |> Repo.insert!
hong_entity_FR = FinancialReport.changeset(%FinancialReport{}, %{entity_id: hong_entity.id}) |> Repo.insert!

kipo_BS = Ecto.build_assoc(kipo_FR, :gov_balance_sheet, 
    %GovBalanceSheet{
        monetary_unit: "KRW", 
        t1s: [%{input: korea.id, output: kipo.id, amount: Decimal.from_float(100.00)}], 
        cashes: [%{KRW: Decimal.new(10000.00)}]}) |> Repo.insert!
hong_entity_BS = Ecto.build_assoc(hong_entity_FR, :balance_sheet, 
        %BalanceSheet{
            cash: Decimal.new(50000.00), 
            t1s: [%{input: korea.id, output: kipo.id, amount: Decimal.from_float(100.00)}]}) \
        |> Repo.insert!



'''

CRYPTO

'''

#? kipo_entity's private_key or signing key or secret key
#? openssl genrsa -out kipo_private_key.pem 2048
#? openssl rsa -in kipo_private_key.pem -pubout > kipo_public_key.pem
kipo_rsa_priv_key = ExPublicKey.load!("./kipo_private_key.pem")
kipo_rsa_pub_key = ExPublicKey.load!("./kipo_public_key.pem")

# kipo_public_sha256 = :crypto.hash(:sha256, kipo_rsa_pub_key)

#? kipo_entity's private_key or signing key or secret key
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


#? Write a subject on policy financing projects
alias Demo.Patents.PatentApplication

kipo_application = PatentApplication.changeset(
    %PatentApplication{
        type: "Patent Application",
        title: "Openhash Banking System",
        applicants: [hong_entity.id],
        inventor: [hong_entity.id],
        description: "This invention is to ...",   
        background_art: ["Previous arts on banking systems has ..."],      
        summary_of_invention: "This is invention is to ...",
        technical_problem: "Previous technologies in electronic banking ...",
        solution_to_problem: "By combining previous blockchain and new ...",
        advantageous_effects_of_invention: "Because of no transaction fees in electronic transactions ...",
        brief_description_of_drawings: ["pic_1 shows ...", "pic_2 shows ..."],    
        description_of_embodiments: "This inventions ...",
        examples: "The explanation hereinafter is not limited to ....",
        industrial_applicability: "By substituting current financial institutions with this new ...",
        patent_literature: ["patent_No 1334_kr", "patent_No 4334_us"],    
        non_patent_literature: ["How to improve user satisfactions on e-banking system"] ,     
        abstract: "This invention is to provide ...",
        drawings: ["pic_1 ", "pic_2"], 

        attached_docs_list: ["document_1", "document_2"],
        attached_docs_hashes: ["hash_of_document_1", "hash_of_document_2"],
        hash_of_attached_docs_hashes: "hash_of_attached_docs_hashes",
    }) |> Repo.insert!


'''

TRANSACTION
Let's assume Tesla is selected as beneficiary of policy finance.
Transaction between kipo and tesla_entity.

'''
alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}

#? write invoice for trade between mr_hong and kipo.
item = Item.changeset(%Item{}, 
    %{
        product_uuid: kipo.id,
        price: Decimal.from_float(10.0),
        document: kipo_application.id
    }) |> Repo.insert!


invoice_items = [%{item_id: item.id, quantity: 1.0, item_name: "특허 출원"}, %{item_id: item.id, quantity: 0.0}]

params = %{
  "buyer" => %{"main" => hong_entity.id, "participants" => hong_entity.id},
  "seller" => %{"main" => kipo.id, "participants" => kipo.id},
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

txn = Transaction.changeset(%Transaction{
    abc_input: hong_entity.id,
    abc_output: kipo.id,
    abc_amount: invoice.total,
    items: [%{report: "final_report"}]
    }) |> Repo.insert!
    

#? Association between Transaction and Invoice
invoice = Ecto.build_assoc(txn, :invoice, invoice) 

'''

Adjust balance_sheet of both.

''' 

#? kipo
alias Demo.ABC.T1

#? Adjust balance_sheet of both.
#? kipo
#? The code below NOT consider any other elements in the t1s list. We should find out just enough elements to pay the invoice total. 
new_t1s = Enum.map(hong_entity_BS.t1s, fn elem ->
    Map.update!(elem, :amount, fn curr_value -> Decimal.sub(curr_value, txn.abc_amount) end)
end)

hong_entity_BS = change(hong_entity_BS) |> \
    Ecto.Changeset.put_change(:t1s, new_t1s) \
    |> Repo.update!

#? kipo Korea
alias Demo.ABC.T1
new_t1s = Enum.map(kipo_BS.t1s, fn elem ->
    Map.update!(elem, :amount, fn curr_value -> Decimal.add(curr_value, txn.abc_amount) end)
end)


kipo_BS = change(kipo_BS) |> \
Ecto.Changeset.put_change(:t1s, new_t1s) \
|> Repo.update!

'''
Non-repudiation: Mulet of kipo
'''

'''
After receiving ABC from kipo, mr_hong makes a payload 
and send it to the mulet of korea_supul to record the transaction 
in the openhash blockchain. 
'''
#? 

'''
First, mr_hong makes the payload of txn, and send it to korea_supul's mulet.
'''
import Poison

# serialize the JSON
msg_serialized = Poison.encode!(txn)

# generate time-stamp
ts = DateTime.utc_now |> DateTime.to_unix

# add a time-stamp
ts_msg_serialized = "#{ts}|#{msg_serialized}"

# generate a secure hash using SHA256 and sign the message with the private key
{:ok, signature} = ExPublicKey.sign(ts_msg_serialized, tesla_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64 signature}"


'''
Second, the kipo_mulet verifies and unserialize the payload from mr_hong. 
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
txn_hash = 
    :crypto.hash(:sha256, recv_msg_serialized) \
    |> Base.encode16() \
    |> String.downcase() 

korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: txn_hash})

'''
Fourth, send the new hash to the mulets of upper supuls. 
'''
#? global_mulet
incoming_hash = korea_mulet.current_hash
global_mulet = Mulet.changeset(global_mulet, %{incoming_hash: incoming_hash})

