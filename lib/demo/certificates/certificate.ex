defmodule Demo.Certificates.Certificate do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "certificates" do
    field :issuer, :string
    field :name, :string
    field :valid_until, :string

    timestamps()
  end

  @doc false
  def changeset(certificate, attrs) do
    certificate
    |> cast(attrs, [:name, :issuer, :valid_until])
    |> validate_required([:name, :issuer, :valid_until])
  end
end
