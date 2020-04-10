defmodule Demo.Trade.UserTransaction do
  @moduledoc """
  UserTransaction module
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Demo.Accounts.User
  alias Demo.Trade.Transaction

  @already_exists "ALREADY_EXISTS"

  @primary_key false
  schema "user_transactions" do
    belongs_to(:user, User, primary_key: true)
    belongs_to(:transaction, Transaction, primary_key: true)

    timestamps()
  end
 
  @required_fields ~w(user_id transaction_id)a
  def changeset(user_transaction, params \\ %{}) do
    user_transaction
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:transaction_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint([:user, :transaction],
      name: :user_id_transaction_id_unique_index,
      message: @already_exists
    )
  end


end
