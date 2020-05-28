defmodule Demo.Invoices.BuyerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :main 
    field :participants
  end

  @fields [:main, :participants]
  def changeset(buyer_embed, params) do
    buyer_embed
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
