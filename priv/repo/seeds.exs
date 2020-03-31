# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Demo.Repo.insert!(%Demo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# for i <- 1..50 do
#   {:ok, _} =
#     Demo.Accounts.create_user(%{
#       type: "Human",
#       username: "user#{i}",
#       name: "User #{i}",
#       email: "user#{i}@test",
#       password_hash: "user#{i} password",
#       phone_number: "555-555-5555"
#     })
# end

# for i <- 1..50 do
#   {:ok, _} =
#     Demo.Trades.create_txn(%{
#       buyer: "buyer #{i}",
#       seller: "seller #{i}",
#       price: "#{i * 100}",
#       where: "dummy place",
#       product: "product#{i}",
#       user_id: 0
#     })
# end
