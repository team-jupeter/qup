defmodule Demo.Invoices.BuyerEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do
    field :main_id
    field :main_name 
    field :participant_ids
    field :participant_names
  end

  @fields [:main_id, :main_name, :participant_ids, :participant_names]
  def changeset(buyer_embed, params) do
    buyer_embed
    |> cast(params, @fields)
    |> validate_required([])
  end
end
