import Ecto.Query
alias Demo.Repo
alias Demo.Invoices.{Item, Invoice, ItemInvoice}


item = Item.changeset(%Item{}, %{name: "Incheon => Jeju", price: "12.5"})
item = Repo.insert!(item)
item2 = Item.changeset(%Item{price: Decimal.new(20)}, %{name: "Jeju => Gwangju"})
Repo.insert(item2)

# invalid_item = Item.changeset(%Item{}, %{name: "Jeju => Gwangju", price: -1.5})

item_ids = Enum.map(Repo.all(Item), fn(item)-> item.id end)
{id1, id2} = {Enum.at(item_ids, 0), Enum.at(item_ids, 1) }

# inv_items = [%{item_id: id1, price: 12.5, quantity: 2}, %{item_id: id2, price: 16, quantity: 3}]
inv_items = [%{item_id: id1, quantity: 2}, %{item_id: id2, quantity: 3}]
 {:ok, inv} = Invoice.create(%{buyer: "Superman", invoice_items: inv_items})

Repo.all(Invoice)
Repo.all(Invoice) |> Repo.preload(:invoice_items)
Repo.get(Invoice, "90f9078c-624d-4424-a68d-4cfeae6f908f") |> Repo.preload(:invoice_items)

Repo.insert(%Item{name: "Seoul-Busan", price: Decimal.new("5")})
Repo.insert(%Item{name: "Incheon-NewYork", price: Decimal.new("22.5")})
Repo.insert(%Item{name: "Incheon-NewYork", price: Decimal.new("22.5")})
Repo.insert(%Item{name: "Incheon-NewYork", price: Decimal.new("22.5")})
Repo.insert(%Item{name: "Cheongju-Osaka", price: Decimal.new("21.5")})
Repo.insert(%Item{name: "Osaka-Beijing", price: Decimal.new("12")})
Repo.insert(%Item{name: "Shanghai-Hochiminh", price: Decimal.new("10")})
Repo.insert(%Item{name: "Shanghai-Hochiminh", price: Decimal.new("10")})

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
