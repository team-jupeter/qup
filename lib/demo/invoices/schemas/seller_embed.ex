defmodule Demo.Invoices.SellerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :entity_id
  end

  def changeset(seller_embed, params) do
    seller_embed
    |> cast(params, [:entity_id])
    |> validate_required([:entity_id])
  end
end
