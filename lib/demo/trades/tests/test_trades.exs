alias Demo.Repo
alias Demo.Trades
alias Demo.Trades.Trade
alias Demo.Accounts.User
alias Demo.Products.Product
alias Demo.Trades.Buyer

user1 = %User{name: "Jupeter"}
user2 = %User{name: "Superman"}
user3 = %User{name: "Batman"}
user4 = %User{name: "Xman"}
user5 = %User{name: "Joker"}

user6 = %User{name: "Asina"}
user7 = %User{name: "KAL"}
user8 = %User{name: "JAL"}
user9 = %User{name: "Dungfang"}
user10 = %User{name: "Fedex"}

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

buyer1 = %Buyer{name: "Buyer Jupeter"}
buyer2 = %Buyer{name: "Buyer Superman"}
buyer3 = %Buyer{name: "Buyer Batman"}
buyer4 = %Buyer{name: "Buyer Xman"}
buyer5 = %Buyer{name: "Buyer Joker"}

seller6 = %Seller{name: "Seller Asina"}
seller7 = %Seller{name: "Seller KAL"}
seller8 = %Seller{name: "Seller JAL"}
seller9 = %Seller{name: "Seller Dungfang"}
seller10 = %Seller{name: "Seller Fedex"}



buyer_1 = Ecto.build_assoc(user_1, :buyers, buyer1)
buyer_2 = Ecto.build_assoc(user_2, :buyers, buyer2)
buyer_3 = Ecto.build_assoc(user_3, :buyers, buyer3)
buyer_4 = Ecto.build_assoc(user_4, :buyers, buyer4)
buyer_5 = Ecto.build_assoc(user_5, :buyers, buyer5)

seller_1 = Ecto.build_assoc(user_6, :sellers, seller1)
seller_2 = Ecto.build_assoc(user_7, :sellers, seller2)
seller_3 = Ecto.build_assoc(user_8, :sellers, seller3)
seller_4 = Ecto.build_assoc(user_9, :sellers, seller4)
seller_5 = Ecto.build_assoc(user_10, :sellers, seller5)


product1 = %Product{name: "incheon_jeju"}
product2 = %Product{name: "busan_gwangju"}
product3 = %Product{name: "jeju_narita"}
product4 = %Product{name: "incheon_daxing"}
product5 = %Product{name: "incheon_newyork"}

passenger_1 = Ecto.build_assoc(airport_2, :passengers, passenger_1)
passenger_2 = Ecto.build_assoc(airport_2, :passengers, passenger_2)
passenger_2 = Ecto.build_assoc(airport_2, :passengers, passenger_2)
passenger_3 = Ecto.build_assoc(airport_3, :passengers, passenger_3)
passenger_4 = Ecto.build_assoc(airport_4, :passengers, passenger_4)
passenger_5 = Ecto.build_assoc(airport_5, :passengers, passenger_5)



user_1 = Repo.insert!(user1)
user_2 = Repo.insert!(user2)
user_3 = Repo.insert!(user3)
user_4 = Repo.insert!(user4)
user_5 = Repo.insert!(user5)
user_6 = Repo.insert!(user6)
user_7 = Repo.insert!(user7)
user_8 = Repo.insert!(user8)
user_9 = Repo.insert!(user9)
user_10 = Repo.insert!(user10)


product1 = %Product{name: "Incheon-Jeju"}
product2 = %Product{name: "Incheon-Narita"}
product3 = %Product{name: "Incheon-Daxing"}
product4 = %Product{name: "Jeju-Busan"}
product5 = %Product{name: "Jeju-Gwangju"}





trade_2 = Repo.insert!(trade2)
trade_3 = Repo.insert!(trade3)
trade_4 = Repo.insert!(trade4)
trade_5 = Repo.insert!(trade5)

user_2 = Repo.preload(user_2, [:trades])
user_3 = Repo.preload(user_3, [:trades])
user_4 = Repo.preload(user_4, [:trades])
user_5 = Repo.preload(user_5, [:trades])


user_changeset_2 = Ecto.Changeset.change(user_2)
user_changeset_3 = Ecto.Changeset.change(user_3)
user_changeset_4 = Ecto.Changeset.change(user_4)
user_changeset_5 = Ecto.Changeset.change(user_5)

user_trades_changeset_2 = user_changeset_2 |> Ecto.Changeset.put_assoc(:trades, [trade_2, trade_3, trade_4])
user_trades_changeset_3 = user_changeset_3 |> Ecto.Changeset.put_assoc(:trades, [trade_3])
user_trades_changeset_4 = user_changeset_4 |> Ecto.Changeset.put_assoc(:trades, [trade, trade_2])
user_trades_changeset_5 = user_changeset_5 |> Ecto.Changeset.put_assoc(:trades, [trade, trade_2, trade_3, trade_4, trade_5])


Repo.update!(user_trades_changeset_2)
Repo.update!(user_trades_changeset_3)
Repo.update!(user_trades_changeset_4)
Repo.update!(user_trades_changeset_5)


