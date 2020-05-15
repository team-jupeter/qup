defmodule Demo.Certificates.Certificate do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "certificates" do
    field :name, :string
    field :issued_by, :string
    field :issued_to, :string
    field :issued_date, :naive_datetime
    field :valid_until, :naive_datetime

    belongs_to :user, Demo.Users.User, type: :binary_id
    
    timestamps()
  end

  @doc false
  def changeset(certificate, attrs) do
    certificate
    |> cast(attrs, [])
    |> validate_required([])
  end
end
