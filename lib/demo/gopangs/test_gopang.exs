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

gab =
  User.changeset(%User{}, %{name: "GAB: Global Autonomous Bank", email: "gab@000011.un"}) \
  |> Repo.insert!()

korea =
  User.changeset(%User{}, %{name: "South Korea", email: "korea@000000.kr"}) |> Repo.insert!()

# ? init entities
alias Demo.Accounts.Entity

hong_entity =
  Entity.changeset(%Entity{}, %{name: "Hong Gildong Entity", email: "hong_gil_dong@8245.kr", entity_address: "제주시 한경면 20-1 해거름전망대"}) \
  |> Repo.insert!()

tomi_entity =
  Entity.changeset(%Entity{}, %{name: "Tomi Kimbab", email: "tomi@3532.kr", entity_address: "제주시 한림읍 11-1"}) |> Repo.insert!()

gopang =
  Entity.changeset(%Entity{}, %{name: "Gopang Hankyng", email: "gopang_hankyung@3435.kr"}) |> Repo.insert!()

# ? build_assoc user and entity
Repo.preload(hong_entity, [:users]) \
|> Ecto.Changeset.change()  \
|> Ecto.Changeset.put_assoc(:users, [mr_hong])  \
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

hong_rsa_priv_key = ExPublicKey.load!("./hong_private_key.pem")
hong_rsa_pub_key = ExPublicKey.load!("./hong_public_key.pem")

tomi_rsa_priv_key = ExPublicKey.load!("./tomi_private_key.pem")
tomi_rsa_pub_key = ExPublicKey.load!("./tomi_public_key.pem")

'''

TRANSACTION
Let's assume hong is selected as beneficiary of policy finance.
Transaction between gopang and hong_entity.

'''

alias Demo.Transactions.Transaction
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Tickets.Ticket

# ? write invoice for trade between mr_hong and gopang.
item =
  Item.changeset(
    %Item{},
    %{
      product_uuid: tomi_entity.id,
      price: Decimal.from_float(1.0),
    }
  ) \
  |> Repo.insert!()

# ? issue an ticket

ticket =
  Ticket.changeset(%Ticket{}, %{
    departure: tomi_entity.entity_address,
    destination: hong_entity.entity_address,
    departure_time: "2020-06-23 23:50:07",
    arrival_time: "2020-06-24 00:20:07",
    item_id: item.id,
    item_size: [%{width: 10, height: 10, length: 30}],
    item_weight: 980,
    caution: "rotenable",
    gopang_fee: Decimal.from_float(0.1),
  }) \
  |> Repo.insert!()


invoice_items = [
  %{item_id: item.id, quantity: 5.0, item_name: "김밥"},
  %{item_id: item.id, quantity: 0.0}
]

params = %{
  "buyer" => %{"main" => hong_entity.id, "participants" => hong_entity.id},
  "seller" => %{"main" => tomi_entity.id, "participants" => tomi_entity.id},
  "invoice_items" => invoice_items
}

{:ok, invoice} = Invoice.create(params)

# invoice = change(invoice) |> Ecto.Changeset.put_change(:total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal)) |> Repo.update!

# ? hash_of_invoice = hong_public_sha256 = :crypto.hash(:sha256, invoice)

'''

Route and Ticket

'''
# ? calculate route, then embed it on the ticket. 


# ? Write Transaction p
alias Demo.Transactions.Transaction
txn =
  Transaction.changeset(%Transaction{
    abc_input: hong_entity.id,
    abc_output: gopang.id,
    abc_amount: invoice.total,
    items: [%{김밥: 5}],
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
{:ok, buyer_signature} = ExPublicKey.sign(ts_msg_serialized, hong_rsa_priv_key)
{:ok, seller_signature} = ExPublicKey.sign(ts_msg_serialized, tomi_rsa_priv_key)

# combine payload
payload = "#{ts}|#{msg_serialized}|#{Base.url_encode64(buyer_signature)}|#{Base.url_encode64(seller_signature)}"

#? send the payload to the NEAREST common supul of both buyer and seller. 


'''

SUPUL
Second, the supul_mulet verifies and unserialize the payload from mr_hong. 

'''

alias Demo.Mulets.Mulet
hankyung_mulet = Ecto.build_assoc(hankyung_supul, :mulet, %{current_hash: hankyung_supul.id})

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
  ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_buyer, hong_rsa_pub_key)

{:ok, sig_valid_seller} =
  ExPublicKey.verify("#{recv_ts}|#{recv_msg_serialized}", recv_sig_seller, tomi_rsa_pub_key)

# assert(sig_valid)

#? Archieve Tickets
alias Demo.Mulets.TicketStorage
alias Demo.Tickets.Payload
payload_archive = Payload.changeset(%Payload{payload: payload}) |> Repo.insert!
payload_archive = Ecto.build_assoc(hankyung_supul, :payloads, payload_archive)

payload_storage = TicketStorage.changeset(%TicketStorage{}, %{new_payload: payload_archive})



#? recv_msg_unserialized = Poison.Parser.parse!(recv_msg_serialized, %{})
# assert(msg == recv_msg_unserialized)




'''

Adjust balance_sheet of both.

'''
alias Demo.ABC.T1

# ? gopang
new_t1s =
  Enum.map(gopang_BS.t1s, fn elem ->
    Map.update!(elem, :amount, fn curr_value -> Decimal.add(curr_value, ticket.gopang_fee) end)
  end)

gopang_BS = change(gopang_BS) |> Ecto.Changeset.put_change(:t1s, new_t1s) |> Repo.update!()


# ? mr_hong
residual_amount = Decimal.sub(Enum.at(hong_entity_BS.t1s, 0).amount, txn.abc_amount)
new_t1s = [%T1{input: hong_entity.id, output: hong_entity.id, amount: residual_amount}]
hong_entity_BS = change(hong_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!

# ? tomi
new_t1s = [%T1{input: hong_entity.id, output: tomi_entity.id, amount: txn.abc_amount} | tomi_entity_BS.t1s]
tomi_entity_BS = change(tomi_entity_BS) |> Ecto.Changeset.put_embed(:t1s, new_t1s) |> Repo.update!


'''

Third, the mulet of supul, state_supul, korea_supul and global_supul openhashes the unserialized message. 

'''

#? Supul Mulet 
#? pretend transmit the message...
#? pretend receive the message...
hankyung_mulet = Ecto.build_assoc(hankyung_supul, :mulet, %{current_hash: hankyung_supul.id}) 

incoming_hash = :crypto.hash(:sha256, payload) \
  |> Base.encode16() \
  |> String.downcase()
hankyung_mulet = Mulet.changeset(hankyung_mulet, %{incoming_hash: incoming_hash})

#? send every 10th payload to the state_supul of supul.

#? StateSupul Mulet 
#? pretend transmit the message...
#? pretend receive the message...
jejudo_mulet = Ecto.build_assoc(jejudo_supul, :mulet, %{current_hash: jejudo_supul.id}) 
jejudo_mulet = Mulet.changeset(jejudo_mulet, %{incoming_hash: incoming_hash})

#? send every 100th payload to the nation_supul of sate_supul.
korea_mulet = Ecto.build_assoc(korea_supul, :mulet, %{current_hash: korea_supul.id}) 
korea_mulet = Mulet.changeset(korea_mulet, %{incoming_hash: incoming_hash})

#? send every 10000th payload to the global_supul of sate_supul.
global_mulet = Ecto.build_assoc(global_supul, :mulet, %{current_hash: global_supul.id}) 
global_mulet = Mulet.changeset(global_mulet, %{incoming_hash: incoming_hash})

#? send every 1000th payload to the supuls of the world.
hankyung_mulet = Mulet.changeset(hankyung_mulet, %{incoming_hash: incoming_hash})






'''

GOPANG

'''
#? assume the gopang of hankyung has calcuated the road sections to be inclued in the route.
alias Demo.Gopangs.RoadSectionEmbed

road_sections = [
    %RoadSectionEmbed{
    section_uid: "qt2453",
    a_spot: %{lagitude: 35.89421911, longitude: 139.94637467, altitude: 39.9463},
    b_spot: %{lagitude: 35.8925543, longitude: 139.94626565, altitude: 34.4567}
    },
    %RoadSectionEmbed{
    section_uid: "qt2454",
    a_spot: %{lagitude: 35.89421425, longitude: 139.946453, altitude: 32.9443},
    b_spot: %{lagitude: 35.892552, longitude: 139.9462665, altitude: 32.455}
    },
    %RoadSectionEmbed{
    section_uid: "qt2456",
    a_spot: %{lagitude: 35.8942165, longitude: 139.9463745, altitude: 36.944},
    b_spot: %{lagitude: 35.8925523, longitude: 139.94626563, altitude: 37.45434}
    },
]


# ? build_assock: allocate a car or cars to the ticket
alias Demo.Cars.Car
car_1 = Car.changeset(%Car{}, %{name: "은하철도_999"}) |> Repo.insert!()
ticket = Ecto.build_assoc(car_1, :tickets, ticket)

#? put_embed
ticket =
  change(ticket) \
  |> Ecto.Changeset.put_embed(:road_sections, road_sections) \
  |> Repo.update!()



'''

SHOW TIME !!! 👻 👻 👻 👻 👻 👻

'''
#? Code machine learning module here !!!!

ticket = change(ticket) \
|> Ecto.Changeset.put_embed(:deliverybox, %{
    code: "adfs3424",
    status: "moving",
    current_location: %{latitude: "위도", longitude: "경도"}}) \
|> Repo.update!()



alias Demo.Gopangs.RouteEmbed
alias Demo.Gopangs.RoadSectionEmbed

route = %RouteEmbed{
    departure_spot: %{lagitude: 35.89421911, longitude: 139.94637467, altitude: 39.9463},
    arrival_spot: %{lagitude: 35.8925543, longitude: 139.94626565, altitude: 34.4567}
  }
  
ticket =
  change(ticket) \
  |> Ecto.Changeset.put_embed(:route, route) \
  |> Repo.update!()

