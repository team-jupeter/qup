defmodule Demo.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Business.Entity

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "products" do
    field :gopang_fee, :decimal
    field :gpc_code, :string
    field :insurance, :string
    field :name, :string
    field :price, :decimal
    field :stars, :decimal
    field :tax, :decimal 
    field :pvr, :decimal #? price to value ratio 가성비 

    embeds_many :comments, Demo.Products.CommentEmbed

    many_to_many(
      :entities,
      Entity,
      # join_through: Demo.Products.AccountsProducts,
      join_through: "entities_products",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :gpc_code, :price, :gopang_fee, :tax, :insurance, :stars])
    |> validate_required([])
    |> cast_embed(:comments)
  end
end
