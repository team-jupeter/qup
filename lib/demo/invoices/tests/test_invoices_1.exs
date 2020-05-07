alias Demo.Repo
alias Demo.invoices
alias Demo.invoices.invoice
alias Demo.Accounts.User
alias Demo.Products.Product
alias Demo.invoices.Buyer
alias Demo.invoices.Seller

import Ecto.Changeset

user1 = %User{name: "Jupeter", buyer: true}
user2 = %User{name: "Superman", buyer: true}
user3 = %User{name: "Batman", buyer: true}
user4 = %User{name: "Xman", buyer: true}
user5 = %User{name: "Joker", buyer: true}

user6 = %User{name: "Asiana", seller: true}
user7 = %User{name: "KAL", seller: true}
user8 = %User{name: "JAL", seller: true}
user9 = %User{name: "Dungfang", seller: true}
user10 = %User{name: "Fedex", seller: true}

user_1 = Repo.insert! user1
user_2 = Repo.insert! user2
user_3 = Repo.insert! user3
user_4 = Repo.insert! user4
user_5 = Repo.insert! user5
user_6 = Repo.insert! user6
user_7 = Repo.insert! user7
user_8 = Repo.insert! user8
user_9 = Repo.insert! user9
user_10 = Repo.insert! user10

# users1 = [user1, user2, user3, user4, user5]
# users2 = [user6, user7, user8, user9, user10]

# for user <- users1 do
#   i = 2
#   users_1 = []
#   user_ = "user_" <> "#{i}"
#   user_ = String.replace(user_, ~s("), "")
#   user_ = Repo.insert! user
#   users_1 = [user_ | users_1]
#   i = i + 1
# end



invoice1 = %invoice{}
invoice2 = %invoice{dummy_product: "Dummy Product", dummy_buyer: "Dummy Buyer"}
invoice3 = %invoice{}
invoice4 = %invoice{}
invoice5 = %invoice{}

invoice_1 = Repo.insert! invoice1
invoice_2 = Repo.insert! invoice2
invoice_3 = Repo.insert! invoice3
invoice_4 = Repo.insert! invoice4
invoice_5 = Repo.insert! invoice5


product1 = %Product{name: "incheon_jeju"}
product2 = %Product{name: "busan_gwangju", category: "air_ticket", base_price: 532}
product3 = %Product{name: "jeju_narita", category: "air_ticket", base_price: 365}
product4 = %Product{name: "incheon_daxing", category: "air_ticket", base_price: 455}
product5 = %Product{name: "incheon_newyork", category: "air_ticket", base_price: 245}

product_1 = Ecto.build_assoc(invoice_1, :products, product1)
product_2 = Ecto.build_assoc(invoice_2, :products, product2)
product_3 = Ecto.build_assoc(invoice_3, :products, product3)
product_4 = Ecto.build_assoc(invoice_4, :products, product4)
product_5 = Ecto.build_assoc(invoice_5, :products, product5)

product_1 = Repo.insert! product_1
product_2 = Repo.insert! product_2
product_3 = Repo.insert! product_3
product_4 = Repo.insert! product_4
product_5 = Repo.insert! product_5


invoice_1 = Repo.preload(invoice_1, [:products, :users])
invoice_2 = Repo.preload(invoice_2, [:products, :users])
invoice_3 = Repo.preload(invoice_3, [:products, :users])
invoice_4 = Repo.preload(invoice_4, [:products, :users])
invoice_5 = Repo.preload(invoice_5, [:products, :users])



### many to many
# Load existing data
user_1 = Repo.preload(user_1, [:invoices])
user_2 = Repo.preload(user_2, [:invoices])
user_3 = Repo.preload(user_3, [:invoices])
user_4 = Repo.preload(user_4, [:invoices])
user_5 = Repo.preload(user_5, [:invoices])
user_6 = Repo.preload(user_6, [:invoices])
user_7 = Repo.preload(user_7, [:invoices])
user_8 = Repo.preload(user_8, [:invoices])
user_9 = Repo.preload(user_9, [:invoices])
user_10 = Repo.preload(user_10, [:invoices])

# Build the changeset
user_changeset_1 = change(user_1)
user_changeset_2 = change(user_2)
user_changeset_3 = change(user_3)
user_changeset_4 = change(user_4)
user_changeset_5 = change(user_5)
user_changeset_6 = change(user_6)
user_changeset_7 = change(user_7)
user_changeset_8 = change(user_8)
user_changeset_9 = change(user_9)
user_changeset_10 = change(user_10)

# Set the association
user_invoices_changeset_1 = user_changeset_1 |> put_assoc(:invoices, [invoice_1])
user_invoices_changeset_2 = user_changeset_2 |> put_assoc(:invoices, [invoice_1, invoice_2])
user_invoices_changeset_3 = user_changeset_3 |> put_assoc(:invoices, [invoice_3])
user_invoices_changeset_4 = user_changeset_4 |> put_assoc(:invoices, [invoice_2])
user_invoices_changeset_5 = user_changeset_5 |> put_assoc(:invoices, [invoice_2, invoice_3, invoice_5])
user_invoices_changeset_6 = user_changeset_6 |> put_assoc(:invoices, [invoice_3, invoice_4,])
user_invoices_changeset_7 = user_changeset_7 |> put_assoc(:invoices, [invoice_2, invoice_3])
user_invoices_changeset_8 = user_changeset_8 |> put_assoc(:invoices, [invoice_4, invoice_5])
user_invoices_changeset_9 = user_changeset_9 |> put_assoc(:invoices, [invoice_5])
user_invoices_changeset_10 = user_changeset_10 |> put_assoc(:invoices, [invoice_2, invoice_5])


Repo.update!(user_invoices_changeset_1)
Repo.update!(user_invoices_changeset_2)
Repo.update!(user_invoices_changeset_3)
Repo.update!(user_invoices_changeset_4)
Repo.update!(user_invoices_changeset_5)
Repo.update!(user_invoices_changeset_6)
Repo.update!(user_invoices_changeset_7)
Repo.update!(user_invoices_changeset_8)
Repo.update!(user_invoices_changeset_9)
Repo.update!(user_invoices_changeset_10)


# In a later moment, we may get all users for a given invoice
invoice = Repo.get(invoice, 1)
users = Repo.all(Ecto.assoc(invoice, :users))

# The users may also be preloaded on the invoice struct for reading
[invoice] = Repo.all(from(u in invoice, where: u.id == 2, preload: :users))
invoice.users #=> [%User{...}, ...]
block_
