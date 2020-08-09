defmodule Demo.T3s do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T3s
  alias Demo.T3s.T3

  def list_t3s do
    Repo.all(T3)
  end

  def get_t3!(id), do: Repo.get!(T3, id)

  def create_t3(attrs \\ %{}) do
    %T3{}
    |> T3.changeset(attrs)
    |> Repo.insert()
  end

  def update_t3(%T3{} = t3, attrs) do
    t3
    |> T3.changeset(attrs)
    |> Repo.update()
  end

  def delete_t3(%T3{} = t3) do
    Repo.delete(t3)
  end

  def change_t3(%T3{} = t3) do
    T3.changeset(t3, %{})
  end

  def get_t3_price(_t1_currency) do
    # ? dummy
    1
  end

  def buy_t3(gab_account, t1_currency, quantity_to_buy) do
    entity = Repo.preload(gab_account, :entity).entity

    # ? return a list of bought t3s.
    t3_price = get_t3_price(t1_currency)
    t1_cost = Decimal.mult(t3_price, quantity_to_buy)

    case gab_account.t1_balance >= t1_cost do
      true ->
        for _i <- 1..quantity_to_buy, do: create_t3(%{current_owner: entity})

      false ->
        "short of T1 balance"
    end
  end

  def sell_t3(gab_account, t1_currency) do
    # ? select the first t3 from the gab_account's t3 list, and change the current owner of t3s to sell to gab name.
    Enum.map(gab_account.t3, fn t3 -> T3s.update_t3(t3, %{current_owner: "GAB"}) end)
    t3_price = get_t3_price(t1_currency)
    Decimal.mult(t3_price, gab_account.t3_balance)
  end
end
