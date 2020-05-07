import Ecto.Query
import Ecto.Changeset
alias Demo.Repo
alias Demo.Invoices.{Item, Invoice, InvoiceItem}
alias Demo.Entities.Entity
alias Demo.Users.User
alias Demo.Nations.Nation

#? entity belongs to both user and nation for double checking nationality of seller and buyer.
#? nation =>(has_many) user =>
#? nation =>(has_many)          entity <=>(many_to_many) seller, buyer
nation1 = Nation.changeset(%Nation{}, %{name: "South Korea"})
korea = Repo.insert!(nation1)
nation2 = Nation.changeset(%Nation{}, %{name: "USA"})
usa = Repo.insert!(nation2)

nation_ids = Enum.map(Repo.all(Nation), fn(nation)-> nation.id end)
{korea_id, usa_id} = {Enum.at(nation_ids, 0), Enum.at(nation_ids, 1) }

[honggildong, trump] = [%User{nation_id: korea_id, name: "Hong Gildong"}, %User{nation_id: usa_id, name: "Donald Trump"}]
honggildong = Repo.insert!(honggildong)
trump = Repo.insert!(trump)

user_ids = Enum.map(Repo.all(User), fn(user)-> user.id end)
{honggildong_id, trump_id} = {Enum.at(user_ids, 0), Enum.at(user_ids, 1) }

entity1 = Entity.changeset(%Entity{}, %{nation_id: korea_id, email: "test1@gmail.com"})
hong_entity = Repo.insert!(entity1)
entity2 = Entity.changeset(%Entity{}, %{nation_id: usa_id, email: "test2@gmail.com"})
trump_entity = Repo.insert!(entity2)



#? item => invoice_item => invoice
item = Item.changeset(%Item{}, %{name: "Incheon => Jeju", price: "12.5"})
item = Repo.insert!(item)
item2 = Item.changeset(%Item{price: Decimal.new(20)}, %{name: "Jeju => Gwangju"})
Repo.insert(item2)

# invalid_item = Item.changeset(%Item{}, %{name: "Jeju => Gwangju", price: -1.5})

item_ids = Enum.map(Repo.all(Item), fn(item)-> item.id end)
{id1, id2} = {Enum.at(item_ids, 0), Enum.at(item_ids, 1) }

# inv_items = [%{item_id: id1, price: 12.5, quantity: 2}, %{item_id: id2, price: 16, quantity: 3}]
inv_items = [%{item_id: id1, quantity: 2}, %{item_id: id2, quantity: 3}]

inv_item = %InvoiceItem{item_id: id1, quantity: 2}
Repo.insert!(inv_item)
#? how to change "Trump" to trump?
{:ok, inv} = Invoice.create(%{buyer: trump, invoice_items: inv_items})




superman = User.changeset(%User{}, %{name: "Superman", email: "superman@2355.kr"})
batman = User.changeset(%User{}, %{name: "Batman", email: "batman@2355.kr"})

superman = Ecto.build_assoc(korea, :users, superman)


nation_ids = Enum.map(Repo.all(Nation), fn(nation)-> nation.id end)
{nation_id1, nation_id2} = {Enum.at(nation_ids, 0), Enum.at(nation_ids, 1) }

superman = %User{nation_id: id1, name: "Superman", email: "superman@2355.kr"}
batman = %{nation_id: id2, name: "Batman", email: "batman@2355.kr"}


# {:ok, superman} = Repo.insert(user1)
# superman_cs = change(superman)
# Repo.update(superman_cs, nation_id: korea_id)
# Repo.update(Ecto.Changeset.change(superman, nation_id: korea_id))


entry1 = Entry.changeset(%Entry{}, )
# inv_items = [%{item_id: id1, price: 12.5, quantity: 2}, %{item_id: id2, price: 16, quantity: 3}]
inv_items = [%{item_id: id1, quantity: 2}, %{item_id: id2, quantity: 3}]
 {:ok, inv} = Invoice.create(%{buyer: "Superman", invoice_items: inv_items})

Repo.all(Invoice)
Repo.all(Invoice) |> Repo.preload(:invoice_items)
Repo.get(Invoice, "90f9078c-624d-4424-a68d-4cfeae6f908f") |> Repo.preload(:invoice_items)

Repo.insert_all(Item, [
  [name: "Seoul-Busan", price: Decimal.new("5")],
  [name: "Incheon-NewYork", price: Decimal.new("22.5")],
  [name: "Incheon-NewYork", price: Decimal.new("22.5")],
  [name: "Incheon-NewYork", price: Decimal.new("22.5")],
  [name: "Cheongju-Osaka", price: Decimal.new("21.5")],
  [name: "Osaka-Beijing", price: Decimal.new("12")],
  [name: "Shanghai-Hochiminh", price: Decimal.new("10")],
  [name: "Shanghai-Hochiminh", price: Decimal.new("10")]
  ])

q = from(i in Item, select: %{name: i.name, count: (i.name)}, group_by: i.name)
Repo.all(q)

l =  Repo.all(from(i in Item, select: {i.name, i.id}))
items = for {k, v} <- l, into: %{}, do: {k, v}

line_items = [%{item_id: items["Shanghai-Hochiminh"], quantity: 2}]



##
### Repo.delete_all(InvoiceItem); Repo.delete_all(Invoice)

li_1 = [%{item_id: items["Shanghai-Hochiminh"], quantity: 2}, %{item_id: items["Osaka-Beijing"], quantity: 1}]
superman_invoice = Invoice.create(%{customer: "Superman", invoice_items: li_1})

li_2 = [%{item_id: items["Cheongju-Osaka"], quantity: 2}| li_1]
batman_invoice = Invoice.create(%{customer: "Batman", invoice_items: li_2})

li_3 = li_2 ++ [%{item_id: items["Incheon-NewYork"], quantity: 3 }, %{item_id: items["Seoul-Busan"], quantity: 1}, %{item_id: items["Osaka-Beijing"], quantity: 1}]
xman_invoice = Invoice.create(%{customer: "Xman", invoice_items: li_3})
