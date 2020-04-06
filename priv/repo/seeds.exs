# Script for populating the database. You can run it as:

#     mix run priv/repo/seeds.exs

# Inside the script, you can read and write to any of your
# repositories directly:

#     Demo.Repo.insert!(%Demo.SomeSchema{})

# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

for i <- 1..10 do
  {:ok, _} =
    Demo.Accounts.create_user(%{
      type: "Human",
      name: "Jupeter#{i}",
      email: "jupeter#{i}@jejudo.kr",
      password: "password",
      balance: 100 * i,
    })
end

for i <- 1..10 do
  {:ok, _} =
    Demo.Trade.create_transaction(%{
      product: "product#{i}",
      price: "#{i * 10}",
      buyer: "buyer #{i}",
      seller: "seller #{i}",
      where: "dummy place",
      buyer_id: "Jupeter#{i}",
      seller_id: "Superman#{10 - i}",
    })
end

