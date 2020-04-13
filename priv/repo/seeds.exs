# Script for populating the database. You can run it as:

#     mix run priv/repo/seeds.exs

# Inside the script, you can read and write to any of your
# repositories directly:

#     Demo.Repo.insert!(%Demo.SomeSchema{})

# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# user_list = ["jupeter", "superman", "batman", "xman", "joker"]

# for i <- user_list do
#   {:ok, _} =
#     Demo.Accounts.create_user(%{
#       type: "Human",
#       name: "#{i}",
#       email: "#{i}@jejudo.kr",
#       password: "password",
#       balance: Enum.random(1_000..10_000),
#     })
# end

# for i <- user_list do
#   {:ok, _} =
#     Demo.Trades.create_trade(%{
#       product: "product#{i}",
#       price: 1000,
#       buyer: "#{i}",
#       seller: "#{i+1}",
#       where: "dummy place",
#       buyer_id: "Jupeter#{i}",
#       seller_id: "Superman#{10 - i}",
#     })
# end

