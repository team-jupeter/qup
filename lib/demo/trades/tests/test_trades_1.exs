alias Demo.Repo
alias Demo.Trades
alias Demo.Trades.Trade
alias Demo.Accounts.User
alias Demo.Products.Product
alias Demo.Trades.Buyer
alias Demo.Trades.Seller

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



trade1 = %Trade{}
trade2 = %Trade{}
trade3 = %Trade{}
trade4 = %Trade{}
trade5 = %Trade{}

trade_1 = Repo.insert! trade1
trade_2 = Repo.insert! trade2
trade_3 = Repo.insert! trade3
trade_4 = Repo.insert! trade4
trade_5 = Repo.insert! trade5


product1 = %Product{name: "incheon_jeju", category: "air_ticket", base_price: 124}
product2 = %Product{name: "busan_gwangju", category: "air_ticket", base_price: 532}
product3 = %Product{name: "jeju_narita", category: "air_ticket", base_price: 365}
product4 = %Product{name: "incheon_daxing", category: "air_ticket", base_price: 455}
product5 = %Product{name: "incheon_newyork", category: "air_ticket", base_price: 245}

product_1 = Ecto.build_assoc(trade_1, :products, product1)
product_2 = Ecto.build_assoc(trade_2, :products, product2)
product_3 = Ecto.build_assoc(trade_3, :products, product3)
product_4 = Ecto.build_assoc(trade_4, :products, product4)
product_5 = Ecto.build_assoc(trade_5, :products, product5)

product_1 = Repo.insert! product_1
product_2 = Repo.insert! product_2
product_3 = Repo.insert! product_3
product_4 = Repo.insert! product_4
product_5 = Repo.insert! product_5


trade_1 = Repo.preload(trade_1, [:products, :users])
trade_2 = Repo.preload(trade_2, [:products, :users])
trade_3 = Repo.preload(trade_3, [:products, :users])
trade_4 = Repo.preload(trade_4, [:products, :users])
trade_5 = Repo.preload(trade_5, [:products, :users])



### many to many
user_1 = Repo.preload(user_1, [:trades])
user_2 = Repo.preload(user_2, [:trades])
user_3 = Repo.preload(user_3, [:trades])
user_4 = Repo.preload(user_4, [:trades])
user_5 = Repo.preload(user_5, [:trades])
user_6 = Repo.preload(user_6, [:trades])
user_7 = Repo.preload(user_7, [:trades])
user_8 = Repo.preload(user_8, [:trades])
user_9 = Repo.preload(user_9, [:trades])
user_10 = Repo.preload(user_10, [:trades])


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


user_trades_changeset_1 = user_changeset_1 |> put_assoc(:trades, [trade_2, trade_3, trade_4])
user_trades_changeset_2 = user_changeset_2 |> put_assoc(:trades, [trade_2, trade_3, trade_4])
user_trades_changeset_3 = user_changeset_3 |> put_assoc(:trades, [trade_3])
user_trades_changeset_4 = user_changeset_4 |> put_assoc(:trades, [trade_1, trade_2])
user_trades_changeset_5 = user_changeset_5 |> put_assoc(:trades, [trade_1, trade_2, trade_3, trade_4, trade_5])
user_trades_changeset_6 = user_changeset_6 |> put_assoc(:trades, [trade_1, trade_3, trade_4, trade_5])
user_trades_changeset_7 = user_changeset_7 |> put_assoc(:trades, [trade_1, trade_2, trade_3, ])
user_trades_changeset_8 = user_changeset_8 |> put_assoc(:trades, [trade_1, trade_2, trade_4, trade_5])
user_trades_changeset_9 = user_changeset_9 |> put_assoc(:trades, [trade_1, trade_2, trade_3, trade_4, trade_5])
user_trades_changeset_10 = user_changeset_10 |> put_assoc(:trades, [trade_1, trade_2, trade_3, trade_5])


Repo.update!(user_trades_changeset_1)
Repo.update!(user_trades_changeset_2)
Repo.update!(user_trades_changeset_3)
Repo.update!(user_trades_changeset_4)
Repo.update!(user_trades_changeset_5)
Repo.update!(user_trades_changeset_6)
Repo.update!(user_trades_changeset_7)
Repo.update!(user_trades_changeset_8)
Repo.update!(user_trades_changeset_9)
Repo.update!(user_trades_changeset_10)


