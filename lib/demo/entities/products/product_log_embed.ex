defmodule Demo.Products.ProductLogEmbed do
  import Ecto.Changeset
  use Ecto.Schema

  embedded_schema do 
    field :who, :string 
    field :when, :string 
    field :where, :string 
    field :what, :string 
    field :how, :string 
    field :why, :string 
    field :to_whom, :string 
  end

  @fields [
   
  ]
  # @required [:name, :crn, :sic_code, :legal_status, :year_started, :num_of_shares]
@fields [
  :who, :when, :where, :what, :how, :why, :to_whom,
]
  def changeset(product_log_embed, params) do
    product_log_embed
    |> cast(params, @fields)
    |> validate_required([])
  end
end
