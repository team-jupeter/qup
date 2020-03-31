defmodule Demo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  # alias Demo.Trades.Transaction

  @required_fields [:name, :username, :email, :phone_number]

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :phone_number, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :password_confirmation, :string, virtual: true

    timestamps()

    # many_to_many(
    #   :transactions,
    #   Transaction,
    #   join_through: "user_transaction",
    #   on_replace: :delete
    # )
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 2, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :username])
    |> validate_required([:name, :username])
    |> validate_length(:username, min: 1, max: 20)
  end
  # @phone ~r/^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/

  # @doc false
  # def changeset(user, attrs) do
  #   user
  #   |> cast(attrs, [:username, :email, :phone_number, :password])
    # |> validate_required([:username, :email, :phone_number])
    # |> validate_confirmation(:password)
    # |> validate_format(:username, ~r/^[a-zA-Z0-9_]*$/,
    #   message: "only letters, numbers, and underscores please"
    # )
    # |> validate_length(:username, max: 12)
    # |> validate_format(:email, ~r/.+@.+/, message: "must be a valid email address")
    # |> validate_format(:phone_number, @phone, message: "must be a valid number")
    # |> unique_constraint(:email)
  # end


  def changeset_update_transactions(user, transactions) do
    user
    |> cast(%{}, @required_fields)
    # associate transactions to the user
    |> put_assoc(:transactions, transactions)
  end

end
