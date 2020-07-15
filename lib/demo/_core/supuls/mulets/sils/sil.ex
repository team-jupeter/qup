defmodule Demo.Sils.Sil do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "sils" do
    field :openhash_box, {:array, :string}
    field :current_hash, :string
    field :report_hash, :string

    belongs_to :entity, Demo.Business.Entity, type: :binary_id
 
    timestamps()
  end

  @doc false
  def changeset(sil, attrs) do
    sil
    |> cast(attrs, [:openhash_box, :current_hash])
    |> validate_required([:current_hash])
    |> generate_hash(attrs.report_hash)
  end

  defp generate_hash(sil_cs, invoice_hash) do
    current_hash = sil_cs.data.current_hash
    new_sil = sil_cs.data.current_hash <> invoice_hash
    new_hash = :crypto.hash(:sha256, new_sil)
    |> Base.encode16()
    |> String.downcase()

    %Demo.Sils.Sil{openhash_box: [current_hash | sil_cs.data.openhash_box], current_hash: new_hash}
  end
end
