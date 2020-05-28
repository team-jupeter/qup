defmodule Demo.Invoices.SellerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :main 
    field :participants
  end

  @fields [:main, :participants]

  def changeset(seller_embed, params) do
    seller_embed
    |> cast(params, @fields)
    |> validate_required([])
  end
end
