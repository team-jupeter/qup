defmodule Demo.Accounts.UsersTrades do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Trades.Trade

  schema "users_trades" do
    belongs_to :users, Demo.Accounts.User
    belongs_to :trades, Demo.Accounts.Trade
  end
end
