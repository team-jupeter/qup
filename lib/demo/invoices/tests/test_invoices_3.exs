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

IO.inspect(changeset.changes.permalinks)
'''

_ = '''
[%Ecto.Changeset{action: :delete, changes: %{},
                 model: %Permalink{url: "example.com/thebest"}},
 %Ecto.Changeset{action: :update, changes: %{},
                 model: %Permalink{url: "another.com/mostaccessed"}}]
'''

#? init supuls. For example, Korea will have about 4,000 supuls.
alias Demo.Supuls.Supul

hankyung_supul = %Supul{name: "Hankyung_County", nation_id: korea_id, supul_code: 52070104} |> Repo.insert!
orange_supul = %Supul{name: "Orange_County", nation_id: usa_id, supul_code: 02171124} |> Repo.insert!

supul_ids = Enum.map(Repo.all(Supul), fn(supul)-> supul.id end)
{hankyung_supul_id, orange_supul_id} = {Enum.at(supul_ids, 0), Enum.at(supul_ids, 1)}

#? init users
#? A user belongs to a nation, and a natural human.
#? A user should have at least one entity, a legal human, which will represent all the economic activities of the user.
alias Demo.Users.User

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
#? We will use a brand_new real_time acccounting principle.
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

hong_sung_entity = Entity.changeset(%Entity{}, %{category: "air_line", name: "Hong & Sung's Hair", nation_id: korea_id, email: "hong_sung@82345.kr", supul_id: hankyung_supul_id, taxation_id: kts_id}) |> Repo.insert!
delta_entity = Entity.changeset(%Entity{}, %{category: "hair_shop", name: "Delta Airline", nation_id: usa_id, email: "delta@023357.us", supul_id: orange_supul_id, taxation_id: irs_id}) |> Repo.insert!


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
alias Demo.Users.User
alias Demo.Users

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

#? find the nation name using the seller_nation_id
seller_nation_id = seller_entity.nation_id
seller_nation_name = Repo.one from nation in Nation,
  where: nation.id == ^seller_nation_id,
  select: nation.name

trade = Trade.changeset(trade, %{seller_nation_name: seller_nation_name}) |> Repo.update!

#? init tax_rates
alias Demo.Taxations.TaxRate

#? add unique constraints
Repo.insert!(%TaxRate{taxation_id: kts_id, gpc_code: "ABCDE1001", tax_percent: Decimal.new("15")})
Repo.insert!(%TaxRate{taxation_id: irs_id, gpc_code: "ABCDE1001", tax_percent: Decimal.new("20")})
Repo.insert!(%TaxRate{taxation_id: irs_id, gpc_code: "ABCDE1003", tax_percent: Decimal.new("22")})


#? find the tax_percent of each invoice_item
#? shamelessly hard coded
#? use "for" statement in real coding
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

invoice_items_1_tax_amount = Decimal.mult(Decimal.mult(invoice_items_1_tax_percent, Enum.at(preloaded_invoice.invoice_items, 0).subtotal), "0.01")
invoice_items_2_tax_amount = Decimal.mult(Decimal.mult(invoice_items_2_tax_percent, Enum.at(preloaded_invoice.invoice_items, 1).subtotal), "0.01")

tax_amount = Decimal.add(invoice_items_1_tax_amount, invoice_items_2_tax_amount)

trade = Trade.changeset(trade, %{tax_amount: tax_amount}) |> Repo.update!








invoice_total = Ecto.Changeset.put_change(trade_cs, :total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal))

#? we need for statement to determine the number of invoice_items in an invoice.
#? shamelessly hard coding below
{:ok, invoice} = Invoice.create(params)
invoice_item_1 = Enum.at(trade.invoice_items, 0)
invoice_item_2 = Enum.at(trade.invoice_items, 1)

Repo.one from tax_rate in TaxRate,
  where: tax_rate.gpc_code == ^invoice_item_1.item.gpc_code,
  where: tax_rate.nation_id == ^seller.nation_id



#? If we want to change a value of a key/field, we first have changeset of the struct which we wanna change.
invoice_item_1_cs = change(invoice_item_1) #? make a changeset

invoice_total = Ecto.Changeset.put_change(trade_cs, :total, Decimal.add(Enum.at(invoice.invoice_items, 0).subtotal, Enum.at(invoice.invoice_items, 1).subtotal))

Repo.update!(invoice_total)
