defmodule Demo.Invoices.SellerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field(:uid)
  end

  def changeset(seller_embed, params) do
    seller_embed
    |> cast(params, [:uid])
    |> validate_required([:uid])
  end
end
