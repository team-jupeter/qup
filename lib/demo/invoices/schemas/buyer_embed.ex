defmodule Demo.Invoices.BuyerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field(:uid)
  end

  def changeset(buyer_embed, params) do
    buyer_embed
    |> cast(params, [:uid])
    |> validate_required([:uid])
  end
end
