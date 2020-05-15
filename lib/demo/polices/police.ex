defmodule Demo.Polices.Police do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "polices" do
    field :name, :string
    field :nationality, :string

    belongs_to :user, Demo.Users.User

    timestamps()
  end

  def registration_changeset(police, params) do
    police
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

  def changeset(police, attrs) do
    police
    |> cast(attrs, [:type, :name, :email, :balance])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
