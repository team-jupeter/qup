defmodule Demo.Invoices.BuyerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :entity_id
    field :entity_address
  end

  def changeset(buyer_embed, params) do
    buyer_embed
    |> cast(params, [:entity_id])
    |> validate_required([:entity_id])
  end
end
