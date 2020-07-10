defmodule Demo.Certificates.Certificate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "certificates" do
    field :auth_code, :string
    field :granted_to, :string
    field :issued_by, :string
    field :issued_on, :string
    field :name, :string
    field :valid_until, :string

    belongs_to :user, Demo.Accounts.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(certificate, attrs) do
    certificate
    |> cast(attrs, [:name, :issued_by, :issued_on, :valid_until, :auth_code, :granted_to])
    |> validate_required([])
  end
end
