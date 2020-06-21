defmodule Demo.Business.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Demo.Business.Entity

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "products" do
    field :gopang_fee, :decimal
    field :insurance, :string
    field :name, :string
    field :price, :decimal
    field :stars, :decimal
    field :tax, :decimal 
    field :pvr, :decimal #? price to value ratio 가성비 

    embeds_many :comments, Demo.Business.CommentEmbed

    belongs_to :gpc_code, Demo.Business.GPCCode
    belongs_to :biz_category, Demo.Business.BizCategory

    many_to_many(
      :entities,
      Entity,
      # join_through: Demo.Products.AccountsProducts,
      join_through: "entities_products",
      on_replace: :delete
    )

    timestamps()
  end

  @fields [
    :name, :price, :gopang_fee, :tax, :insurance, :stars,
    :biz_category_id
  ]
  @doc false
  def changeset(product, attrs \\ %{}) do
    product
    |> cast(attrs, @fields)
    |> validate_required([])
    |> cast_embed(:comments)
    |> assoc_constraint(:gpc_code)
    |> assoc_constraint(:biz_category)
  end
end
