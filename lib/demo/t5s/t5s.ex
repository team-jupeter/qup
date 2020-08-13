defmodule Demo.T5s do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.T5s
  alias Demo.T5s.T5

  def list_t5s do
    Repo.all(T5)
  end

  def get_t5!(id), do: Repo.get!(T5, id)

  def create_t5(attrs \\ %{}) do
    %T5{}
    |> T5.changeset(attrs)
    |> Repo.insert()
  end

  def update_t5(%T5{} = t5, attrs) do
    t5
    |> T5.changeset(attrs)
    |> Repo.update()
  end

  def delete_t5(%T5{} = t5) do
    Repo.delete(t5)
  end

  def change_t5(%T5{} = t5) do
    T5.changeset(t5, %{})
  end

  def get_t5_price(_t1_currency) do
    # ? dummy
    1
  end

  def buy_t5(gab_account, t1_currency, quantity_to_buy) do
    entity = Repo.preload(gab_account, :entity).entity

    # ? return a list of bought t5s.
    t5_price = get_t5_price(t1_currency)
    t1_cost = Decimal.mult(t5_price, quantity_to_buy)

    case gab_account.t1_balance >= t1_cost do
      true ->
        for _i <- 1..quantity_to_buy, do: create_t5(%{current_owner: entity})

      false ->
        "short of T1 balance"
    end
  end

  def sell_t5(gab_account, t1_currency) do
    # ? select the first t5 from the gab_account's t5 list, and change the current owner of t5s to sell to gab name.
    Enum.map(gab_account.t5, fn t5 -> T5s.update_t5(t5, %{current_owner: "GAB"}) end)
    t5_price = get_t5_price(t1_currency)
    Decimal.mult(t5_price, gab_account.t5_balance)
  end
end
