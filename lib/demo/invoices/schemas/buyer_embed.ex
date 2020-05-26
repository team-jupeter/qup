defmodule Demo.Invoices.BuyerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :entity_id
    field :public_address
  end

  @fields [:entity_id, :public_address]
  def changeset(buyer_embed, params) do
    buyer_embed
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
