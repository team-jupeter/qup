defmodule Demo.Invoices.SellerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :entity_id
    field :entity_address

  end

  def changeset(seller_embed, params) do
    seller_embed
    |> cast(params, [:entity_id, :entity_address])
    |> validate_required([:entity_id, :entity_address])
  end
end
