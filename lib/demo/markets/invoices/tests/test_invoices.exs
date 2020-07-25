import Ecto.Query
import Ecto.Changeset
alias Demo.Repo


#? entity belongs to user and, users belong to nation for double checking nationality of seller and buyer.
#? nation =>(has_many) user =>
#? nation =>(has_many)          entity <=>(many_to_many) seller, buyer

#? init 194 nations
alias Demo.Nations.Nation

nation1 = Nation.changeset(%Nation{}, %{name: "South Korea"})
korea = Repo.insert!(nation1)
nation2 = Nation.changeset(%Nation{}, %{name: "USA"})
usa = Repo.insert!(nation2)

nation_ids = Enum.map(Repo.all(Nation), fn(nation)-> nation.id end)
{korea_id, usa_id} = {Enum.at(nation_ids, 0), Enum.at(nation_ids, 1) }

nations = Repo.all(Nation)
Repo.preload nations, :taxation

_='''
#? Permalink of nations
# Generate a changeset for the post
changeset = Ecto.Changeset.change(nation1)

# Let's track the new permalinks
changeset = Ecto.Changeset.put_embed(changeset, :permalinks,
  [%Permalink{url: "supul.org/korea"},
   %Permalink{url: "supul.org/government"}]
)

# Now insert the post with permalinks at once
post = Repo.insert!(changeset)

# Remove all permalinks from example.com
permalinks = Enum.reject post.permalinks, fn permalink ->
  permalink.url =~ "example.com"
end

# Let's create a new changeset
changeset =
  post
  |> Ecto.Changeset.change
  |> Ecto.Changeset.put_embed(:permalinks, permalinks)

# And update the entry
post = Repo.update!(changeset)

'''

_ = '''
[%Ecto.Changeset{action: :delete, changes: %{},
                 model: %Permalink{url: "example.com/thebest"}},
 %Ecto.Changeset{action: :update, changes: %{},
                 model: %Permalink{url: "another.com/mostaccessed"}}]
'''

#? init supuls. For example, Korea will have about 4,000 supuls.
alias Demo.Supuls.Supul

hankyung_supul = %Supul{name: "Hankyung_County", nation_id: korea_id, supul_code: 0x52070104} |> Repo.insert!
hallim_supul = %Supul{name: "Hallim_County", nation_id: korea_id, supul_code: 0x52070102} |> Repo.insert!
orange_supul = %Supul{name: "Orange_County", nation_id: usa_id, supul_code: 0x01171124} |> Repo.insert!

supul_ids = Enum.map(Repo.all(Supul), fn(supul)-> supul.id end)
{hankyung_supul_id, orange_supul_id} = {Enum.at(supul_ids, 0), Enum.at(supul_ids, 1)}

#? init users
#? A user belongs to a nation, and a natural human.
#? A user should have at least one entity, a legal human, which will represent all the economic activities of the user.
alias Demo.Accounts.User

[gildong, chunhyang, trump] = [%User{nation_id: korea_id, name: "Mr.Hong"}, %User{nation_id: korea_id, name: "Ms.Sung"},%User{nation_id: usa_id, name: "Donald Trump"}]
mr_hong = Repo.insert!(gildong)
ms_sung = Repo.insert!(chunhyang)
trump = Repo.insert!(trump)

user_ids = Enum.map(Repo.all(User), fn(user)-> user.id end)
{hong_id, sung_id, trump_id} = {Enum.at(user_ids, 0), Enum.at(user_ids, 1), Enum.at(user_ids, 2)}

#? init health_reports
#? its a report for naturnal person, user.
#? Every health report will be signed by a hospital which is approved by the nation in which the user belongs to.
#? Any authority such as airports may confirm the health status of passengers.
#? We need a standard protocol on health report to entrust each other among all the nations.
alias Demo.Reports.HealthReport

[gildong_health, chunhyang_health, trump_health] =
  [
    %HealthReport{user_id: hong_id, infection: false},
    %HealthReport{user_id: sung_id, infection: false},
    %HealthReport{user_id: trump_id, infection: false}
  ]

mr_hong_health = Repo.insert!(gildong_health)
ms_sung_health = Repo.insert!(chunhyang_health)
trump_health = Repo.insert!(trump_health)


#? init taxations
#? We need a standard protocal to treat trades among people with different nationalities.
#? Normally people have used cash_basis accounting principles.
#? We will use a brand_new real_time accounting principle.
alias Demo.Taxations.Taxation

korea_taxation = %Taxation{name: "Korea Tax Service", nation_id: korea_id} |> Repo.insert!
usa_taxation = %Taxation{name: "US Internal Revenue Service", nation_id: usa_id} |> Repo.insert!

taxation_ids = Enum.map(Repo.all(Taxation), fn(taxation)-> taxation.id end)
{kts_id, irs_id} = {Enum.at(taxation_ids, 0), Enum.at(taxation_ids, 1)}


#? init entities
#? An entity is a economic representation of at least one user.
#? An entity is similar to current legal humans.
#? the relationship between entities and usera are many_to_many
#? every entity belongs to a nation.
#? every entity belongs to a supul.

alias Demo.Entities.Entity

hong_sung_entity = Entity.changeset(%Entity{}, %{category: "hairshop", name: "Hong & Sung's Hair", nation_id: korea_id, email: "hong_sung@82345.kr", supul_id: hankyung_supul_id, taxation_id: kts_id}) |> Repo.insert!
delta_entity = Entity.changeset(%Entity{}, %{category: "airline", name: "Delta Airline", nation_id: usa_id, email: "delta@023357.us", supul_id: orange_supul_id, taxation_id: irs_id}) |> Repo.insert!


entity_ids = Enum.map(Repo.all(Entity), fn(entity)-> entity.id end)
{hong_sung_entity_id, delta_entity_id} = {Enum.at(entity_ids, 0), Enum.at(entity_ids, 1) }

#? init financial_reports
#? FR is to record economic activities of an entity.
#? A supul will consolidate all the entities' FS which it has.
alias Demo.Reports.FinancialReport

hong_sung_report = %FinancialReport{entity_id: hong_sung_entity_id} |> Repo.insert!
delta_report = %FinancialReport{entity_id: delta_entity_id} |> Repo.insert!


#? init GAB(Global Autonomous Bank) accounts
#? Every BS has a field named "gab_account".
#? Every entity has one "gab_account"
#? FS is a standard form which citizens of 194 nations can share.
#? FS should be recorded by Standard Currency(ABC: Asset Backed Cryptocurrency)
#? SC can be converted to any fiat currency in real time according to exchange rates.
#? an entity can view his/her/its FS in any currency type.
#? Thought all FS are recorded in SC, they can be viewed in any currency type.
alias Demo.Reports.BalanceSheet

financial_report_ids = Enum.map(Repo.all(FinancialReport), fn(financial_report)-> financial_report.id end)
{hong_sung_report_id, delta_report_id} = {Enum.at(financial_report_ids, 0), Enum.at(financial_report_ids, 1) }

hong_sung_BS = %BalanceSheet{financial_report_id: hong_sung_report_id, gab_account: 1000} |> Repo.insert
delta_BS = %BalanceSheet{financial_report_id: delta_report_id, gab_account: 2000} |> Repo.insert


#? users_entities
alias Demo.Entities.Entity
alias Demo.Accounts.User
alias Demo.Accounts

# preload
hs_entity = Repo.preload(hong_sung_entity, [:users])
delta_entity = Repo.preload(delta_entity, [:users])

# changeset
hs_entity_cs = Ecto.Changeset.change(hs_entity)
delta_entity_cs = Ecto.Changeset.change(delta_entity)

hs_users_entities_cs = hs_entity_cs |> Ecto.Changeset.put_assoc(:users, [ms_sung, mr_hong])
Repo.update!(hs_users_entities_cs)

delta_users_entities_cs = delta_entity_cs |> Ecto.Changeset.put_assoc(:users, [trump, ms_sung])
Repo.update!(delta_users_entities_cs)

_= '''
Note we are using cast_assoc instead of put_assoc in this example.
Both functions are defined in Ecto.Changeset.
cast_assoc (or cast_embed) is used when you want to manage associations
or embeds based on external parameters, such as the data received through
Phoenix forms. In such cases, Ecto will compare the data existing in the
struct with the data sent through the form and generate the proper operations.
On the other hand, we use put_assoc (or put_embed) when we aleady have
the associations (or embeds) as structs and changesets, and we simply want
to tell Ecto to take those entries as is.
'''

#? item => invoice_item => invoice
#? item
alias Demo.Invoices.{Item, Invoice, InvoiceItem}

item1 = Item.changeset(%Item{}, %{gpc_code: "ABCDE1001", category: "air_ticket", name: "Incheon => Jeju", price: "12.5"}) |> Repo.insert!
item2 = Item.changeset(%Item{price: Decimal.new(20)}, %{gpc_code: "ABCDE1003", category: "air_ticket", name: "Jeju => Gwangju"}) |> Repo.insert!


# invalid_item = Item.changeset(%Item{}, %{name: "Jeju => Gwangju", price: -1.5})

item_ids = Enum.map(Repo.all(Item), fn(item)-> item.id end)
{id1, id2} = {Enum.at(item_ids, 0), Enum.at(item_ids, 1) }

# inv_items = [%{item_id: id1, price: 12.5, quantity: 2}, %{item_id: id2, price: 16, quantity: 3}]
invoice_items = [%{item_id: id1, quantity: 2}, %{item_id: id2, quantity: 3}]


#? add total to invoice
# {:ok, inv} = Invoice.create(%{buyer: h_entity_id, seller: d_entity_id, invoice_items: inv_items})

entity_ids = Enum.map(Repo.all(Entity), fn(entity)-> entity.id end)
{hs_entity_id, d_entity_id} = {Enum.at(entity_ids, 0), Enum.at(entity_ids, 1) }

params = %{
  "buyer" => %{"entity_id" => hs_entity_id},
  "seller" => %{"entity_id" => d_entity_id},
  "invoice_items" => invoice_items
}

Invoice.create(params)

{:ok, invoice} = Invoice.create(params)

#? If we want to change a value of a key/field, we first have changeset of the struct which we wanna change.
invoice_cs = change(invoice) #? make a changeset

invoice_total = Ecto.Changeset.put_change(invoice_cs, :total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal))

Repo.update!(invoice_total)


# Repo.all(Invoice)
# Repo.all(Invoice) |> Repo.preload(:invoice_items)
# Repo.get(Invoice, "90f9078c-624d-4424-a68d-4cfeae6f908f") |> Repo.preload(:invoice_items)
# hong_sung_report = %FinancialReport{entity_id: hong_sung_entity_id} |> Repo.insert!


#? number of each item spec
# q = from(i in Item, select: %{name: i.name, count: (i.name)}, group_by: i.name)
q = from(i in Item, select: %{name: i.name, count: fragment("count(*)")}, group_by: i.name)
Repo.all(q)

#? eliminate duplicate items
l =  Repo.all(from(i in Item, select: {i.name, i.id}))
items = for {k, v} <- l, into: %{}, do: {k, v}



#? Trade
alias Demo.Trades.Trade

#? init a trade
trade = %Trade{} |> Repo.insert!

#? preload without nested association
_ = Repo.one from invoice in Invoice,
  where: invoice.id == ^invoice.id,
  preload: [:invoice_items]

trade = Trade.changeset(trade, %{invoice_id: invoice.id}) |> Repo.update!

#? preload invoice with nested association
preloaded_invoice = Repo.one from invoice in Invoice,
  where: invoice.id == ^invoice.id,
  preload: [invoice_items: :item]

#? find the taxation name using the seller_taxation_id
seller_entity_id = preloaded_invoice.seller.entity_id
seller_entity = Repo.one from entity in Entity,
  where: entity.id == ^seller_entity_id

seller_entity_name = Repo.one from entity in Entity,
  where: entity.id == ^seller_entity_id,
  select: entity.name

trade = Trade.changeset(trade, %{seller_entity_name: seller_entity_name}) |> Repo.update!

#? find the supul name using the seller_supul_id
seller_supul_id = seller_entity.supul_id
seller_supul_name = Repo.one from supul in Supul,
  where: supul.id == ^seller_supul_id,
  select: supul.name

trade = Trade.changeset(trade, %{seller_supul_name: seller_supul_name}) |> Repo.update!

#? find the taxation name using the seller_taxation_id
seller_taxation_id = seller_entity.taxation_id
seller_taxation_name = Repo.one from taxation in Taxation,
  where: taxation.id == ^seller_taxation_id,
  select: taxation.name

trade = Trade.changeset(trade, %{seller_taxation_name: seller_taxation_name}) |> Repo.update!
# trade = Trade.changeset(trade, %{seller_taxation_id: seller_taxation_id}) |> Repo.update!

#? find the nation name using the seller_nation_id
seller_nation_id = seller_entity.nation_id
seller_nation_name = Repo.one from nation in Nation,
  where: nation.id == ^seller_nation_id,
  select: nation.name

trade = Trade.changeset(trade, %{seller_nation_name: seller_nation_name}) |> Repo.update!

#? init tax_rates
alias Demo.Taxations.TaxRate

#? add unique constraints
#? Korean Tax Service, Internal Revenue Service

Repo.insert!(%TaxRate{taxation_id: kts_id, gpc_code: "ABCDE1001", tax_percent: Decimal.new("15")})
Repo.insert!(%TaxRate{taxation_id: irs_id, gpc_code: "ABCDE1001", tax_percent: Decimal.new("20")})
Repo.insert!(%TaxRate{taxation_id: irs_id, gpc_code: "ABCDE1003", tax_percent: Decimal.new("22")})


#? find the tax_percent of each invoice_item
#? shamelessly hard coded
#? use "for" statement in real coding

_='''
1. An invoice has many invoice_items
2. An invoice_item has subtotal, item name, quantity of the item.
3. A tax_rate has gpc_code, tax_percent
4. An item has gpc_code
5. We can calculate the total tax amount of an invoice using the above.
total tax amount of an invoice = sum(subtotal of each invoice_item * tax_rate of the item in the invoice_item)
'''

invoice_items_1_gpc_code = Enum.at(preloaded_invoice.invoice_items, 0).item.gpc_code
invoice_items_2_gpc_code = Enum.at(preloaded_invoice.invoice_items, 1).item.gpc_code

invoice_items_1_subtotal =  Enum.at(preloaded_invoice.invoice_items, 0).subtotal
invoice_items_2_subtotal =  Enum.at(preloaded_invoice.invoice_items, 1).subtotal

invoice_items_1_tax_percent = Repo.one from tax_rate in TaxRate,
  where: tax_rate.taxation_id == ^seller_taxation_id and tax_rate.gpc_code == ^invoice_items_1_gpc_code,
  select: tax_rate.tax_percent

invoice_items_2_tax_percent = Repo.one from tax_rate in TaxRate,
where: tax_rate.taxation_id == ^seller_taxation_id and tax_rate.gpc_code == ^invoice_items_2_gpc_code,
select: tax_rate.tax_percent

invoice_items_1_tax_amount = Decimal.mult(Decimal.mult(invoice_items_1_tax_percent, Enum.at(preloaded_invoice.invoice_items, 0).subtotal), "0.1")
invoice_items_2_tax_amount = Decimal.mult(Decimal.mult(invoice_items_2_tax_percent, Enum.at(preloaded_invoice.invoice_items, 1).subtotal), "0.1")

tax_amount = Decimal.add(invoice_items_1_tax_amount, invoice_items_2_tax_amount)

trade = Trade.changeset(trade, %{tax_amount: tax_amount}) |> Repo.update!
trade = Trade.changeset(trade, %{taxation_id: seller_taxation_id}) |> Repo.update!

#? Supul Context
#? 16 bit digits(hexa decimal)
jejusi_supul = %Supul{name: "Jejusi", nation_id: korea_id, supul_code: 0x52130102} |> Repo.insert!
jejudo_supul = %Supul{name: "Jejudo", nation_id: korea_id, supul_code: 0x52130100} |> Repo.insert!
seoul_supul = %Supul{name: "Seoul", nation_id: korea_id, supul_code: 0x52010000} |> Repo.insert!
korea_supul = %Supul{name: "Korea", nation_id: korea_id, supul_code: 0x52000000} |> Repo.insert!
usa_supul = %Supul{name: "USA", nation_id: korea_id, supul_code: 0x01000000} |> Repo.insert!
global_supul = %Supul{name: "Global", supul_code: 0x00000000} |> Repo.insert!



#? buyer_entity_id
buyer_entity_id = preloaded_invoice.buyer.entity_id
buyer_entity = Repo.one from entity in Entity,
where: entity.id == ^buyer_entity_id

#? seller_entity_id
seller_entity_id = preloaded_invoice.seller.entity_id
seller_entity = Repo.one from entity in Entity,
where: entity.id == ^seller_entity_id

#? buyer_supul_id
buyer_supul_id = Repo.one from supul in Supul,
where: supul.id == ^buyer_entity.supul_id,
select: supul.id

#? seller_supul_id
seller_supul_id = Repo.one from supul in Supul,
where: supul.id == ^seller_entity.supul_id,
select: supul.id

seller_supul = Repo.one from supul in Supul,
where: supul.id == ^seller_entity.supul_id

#? generate two financial reports for buyer and seller
hs_report = Repo.insert!(%FinancialReport{entity_id: buyer_entity_id, supul_id: buyer_supul_id})
delta_report = Repo.insert!(%FinancialReport{entity_id: seller_entity_id, supul_id: seller_supul_id})

#? init two balance sheets for the two reports above
bs_1 = Repo.insert!(%BalanceSheet{financial_report_id: hs_report.id})
bs_2 = Repo.insert!(%BalanceSheet{financial_report_id: delta_report.id})

#? add balance sheet to report
hs_report = FinancialReport.changeset(hs_report, %{balance_sheet: bs_1}) |> Repo.update!
delta_report = FinancialReport.changeset(delta_report, %{balance_sheet: bs_2}) |> Repo.update!

#? preload reports
preloaded_hs_report = Repo.one from report in FinancialReport,
  where: report.id == ^hs_report.id,
  preload: [:balance_sheet, :supul]

preloaded_delta_report = Repo.one from report in FinancialReport,
  where: report.id == ^delta_report.id,
  preload: [:balance_sheet, :supul]



#? add initial gab_amount to the gab_account of seller balance sheet.
delta_bs = preloaded_delta_report.balance_sheet
delta_bs = BalanceSheet.changeset(delta_bs, %{gab_account: 10000}) |> Repo.update!

hs_bs = preloaded_hs_report.balance_sheet
hs_bs = BalanceSheet.changeset(hs_bs, %{gab_account: 5000}) |> Repo.update!

#? gab_account adjustments.
new_delta_gab_account = Decimal.add(delta_bs.gab_account, invoice.total)
new_hs_gab_account = Decimal.sub(hs_bs.gab_account, invoice.total)

#? generate changesets of seller and buyer, reflecting account adjustments.
delta_bs_cs =  BalanceSheet.changeset(delta_bs, %{gab_account: new_delta_gab_account})
hs_bs_cs =  BalanceSheet.changeset(hs_bs, %{gab_account: new_hs_gab_account})

#? Adjust gab_balances of seller and buyer
#? both update  will succeed or both fail, not just one.
Ecto.Multi.new() |>
   Ecto.Multi.update(:seller, delta_bs_cs) |>
   Ecto.Multi.update(:buyer, hs_bs_cs) |>
   Repo.transaction

#? Supul Codes
#? buyer_supul_code
buyer_entity_id = preloaded_invoice.buyer.entity_id
buyer_entity = Repo.one from entity in Entity, where: entity.id == ^buyer_entity_id
buyer_supul_code = Repo.one from supul in Supul, where: supul.id == ^buyer_entity.supul_id, select: supul.supul_code

#? seller_supul_code
seller_supul_name = Repo.one from supul in Supul,
where: supul.id == ^seller_entity.supul_id,
select: supul.supul_code

#? common supul_code
#? shamefully hard coded. Write codes to determine the common supul of buyer and seller.
supul_code = 0x00000000


#? Tickets
#? init a few entities
incheon_airport_entity = Entity.changeset(%Entity{}, %{category: "airport", name: "Incheon Airport", nation_id: korea_id, email: "incheon_airport@82345.kr", supul_id: hankyung_supul_id, taxation_id: kts_id}) |> Repo.insert!
new_york_airport_entity = Entity.changeset(%Entity{}, %{category: "airport", name: "New York Airport", nation_id: korea_id, email: "new_york_airport@82345.kr", supul_id: orange_supul_id, taxation_id: irs_id}) |> Repo.insert!

asina_entity = Entity.changeset(%Entity{}, %{category: "airline", name: "Asina Airline", nation_id: korea_id, email: "asina@82345.kr", supul_id: hankyung_supul_id, taxation_id: kts_id}) |> Repo.insert!
delta_entity = Entity.changeset(%Entity{}, %{category: "airline", name: "Delta Airline", nation_id: usa_id, email: "delta@023357.us", supul_id: orange_supul_id, taxation_id: irs_id}) |> Repo.insert!

jeju_bus_entity = Entity.changeset(%Entity{}, %{category: "bus", name: "Jeju Bus Corp.", nation_id: korea_id, email: "jeju_bus@023357.us", supul_id: hankyung_supul_id, taxation_id: kts_id}) |> Repo.insert!

jeju_ferry_entity = Entity.changeset(%Entity{}, %{category: "Ferry", name: "Jeju ferry Corp.", nation_id: korea_id, email: "jeju_bus@023357.us", supul_id: hankyung_supul_id, taxation_id: kts_id}) |> Repo.insert!

jeju_taxi_entity = Entity.changeset(%Entity{}, %{category: "taxi", name: "Jeju Taxi Corp.", nation_id: korea_id, email: "jeju_taxi@023357.us", supul_id: hankyung_supul_id, taxation_id: kts_id}) |> Repo.insert!

ktx_entity = Entity.changeset(%Entity{}, %{category: "train", name: "KTX Corp.", nation_id: korea_id, email: "ktx@023357.us", supul_id: hankyung_supul_id, taxation_id: kts_id}) |> Repo.insert!

#? entity_ids
entity_ids = Enum.map(Repo.all(Entity), fn(entity)-> entity.id end)
{hong_sung_entity_id, delta_entity_id} = {Enum.at(entity_ids, 0), Enum.at(entity_ids, 1) }



#? init a few terminals
alias Demo.Terminals.Terminal

incheon_airport = Repo.insert!(%Terminal{type: "airport", name: "Incheon Airport", nation_id: korea_id})
ny_airport = Repo.insert!(%Terminal{type: "airport", name: "New York Airport", nation_id: usa_id})
jeju_airport = Repo.insert!(%Terminal{type: "airport", name: "Jeju Airport", nation_id: korea_id})

jeju_bus_terminal = Repo.insert!(%Terminal{type: "bus_terminal", name: "Jeju Bus Terminal", nation_id: korea_id})
jeju_ferry_terminal = Repo.insert!(%Terminal{type: "ferry_terminal", name: "Jeju Ferry Terminal", nation_id: korea_id})
jeju_taxi_terminal = Repo.insert!(%Terminal{type: "taxi_terminal", name: "Jeju Taxi", nation_id: korea_id})

seoul_station = Repo.insert!(%Terminal{type: "train_station", name: "Seoul Railway Station", nation_id: korea_id})

#? init a few transports
alias Demo.Transports.Transport

asiana_3534 = Repo.insert!(%Transport{transport_type: "airplane", transport_id: "asiana_3534", purpose: "passengers", entity_id: asina_entity.id})
delta_1452 = Repo.insert!(%Transport{transport_type: "airplane", transport_id: "delta_1452", purpose: "passengers", entity_id: delta_entity.id})
kal_2234 = Repo.insert!(%Transport{transport_type: "airplane", transport_id: "kal_2234", purpose: "cargo", entity_id: asina_entity.id})
jeju_air_6634 = Repo.insert!(%Transport{transport_type: "airplane", transport_id: "jeju_air_6634", purpose: "cargo", entity_id: asina_entity.id})

jeju_bus_7734 = Repo.insert!(%Transport{transport_type: "bus", transport_id: "jeju_bus_7734", purpose: "passengers", entity_id: jeju_bus_entity.id})
jeju_taxi_7884 = Repo.insert!(%Transport{transport_type: "taxi", transport_id: "jeju_taxi_7884", purpose: "passengers", entity_id: jeju_taxi_entity.id})
jeju_ferry_7004 = Repo.insert!(%Transport{transport_type: "ferry", transport_id: "jeju_ferry_7004", purpose: "passengers", entity_id: jeju_ferry_entity.id})
ktx_1004 = Repo.insert!(%Transport{transport_type: "train", transport_id: "ktx_1004", purpose: "passengers", entity_id: ktx_entity.id})

#? many to many between terminals and transports
incheon_airport = Repo.preload(incheon_airport, [:transports])
ny_airport = Repo.preload(ny_airport, [:transports])

incheon_airport_cs = change(incheon_airport)
ny_airport_cs = change(ny_airport)

incheon_airport_transport_cs = put_assoc(incheon_airport_cs, :transports, [
  asiana_3534 = Repo.insert!(%Transport{transport_type: "airline", transport_id: "asiana_3534", purpose: "passengers"}),
  delta_1452 = Repo.insert!(%Transport{transport_type: "airline", transport_id: "delta_1452", purpose: "passengers"}),
])
Repo.update!(incheon_airport_transport_cs)

ny_airport_transport_cs = put_assoc(ny_airport_cs, :transports, [
  delta_1452 = Repo.insert!(%Transport{transport_type: "airline", transport_id: "delta_1452", purpose: "passengers", entity: delta_entity}),
  kal_2234 = Repo.insert!(%Transport{transport_type: "airline", transport_id: "kal_2234", purpose: "cargo", entity: asina_entity}),
  jeju_air_6634 = Repo.insert!(%Transport{transport_type: "airline", transport_id: "jeju_air_6634", purpose: "cargo", entity: asina_entity})
])
Repo.update!(ny_airport_transport_cs)
 
#? init some tickets
alias Demo.Tickets.Ticket

air_ticket_1 = Repo.insert!(%Ticket{
  transport_type: "airline",
  transport_id: delta_1452.id,
  issued_by: delta_entity.id,
  user_id: mr_hong.id,
  departure_time: ~N[2020-05-14 21:30:00],
  arrival_time: ~N[2020-05-15 13:45:00],
  departing_terminal: incheon_airport.id,
  arrival_terminal: ny_airport.id,
  valid_until: ~N[2020-05-14 21:30:00]
  })

#? users context
doctor_1 = Repo.insert(%Entity{user_id: mr_hong.id, certificate: "Diagnostic doctor"})

