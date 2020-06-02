defmodule Demo.Certificates.Certificate do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "certificates" do
    field :name, :string
    field :issued_by, :binary_id
    field :issued_to, :binary_id
    field :issued_date, :date
    field :valid_until, :date
    field :document, :binary_id

    belongs_to :user, Demo.Users.User, type: :binary_id
    
    timestamps()
  end

  @doc false
  def changeset(certificate, attrs \\ %{}) do
    certificate
    |> cast(attrs, [])
    |> validate_required([])
  end
end
