defmodule Demo.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset 
  # alias Demo.Products.Entity
  alias Demo.Products.Product
  alias Demo.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "products" do
    field :type, :string
    field :name, :string
    field :price, :decimal 
    field :quantity, :decimal
    field :stars, :decimal
    field :pvr, :decimal #? price to value ratio 가성비 
    field :description, :string 
    field :document_hash, :string
    field :owner, {:array, :string}

    field :seller_id, :binary_id
    field :seller_name, :string
    field :seller_supul_id, :binary_id
    field :seller_supul_name, :string

    field :arrived_when, :naive_datetime #? when arrived to the entity
    field :stored_at, :string #? unique warehouse or device name
    field :managed_by, :string #? unique user name
    field :expiration_date, :naive_datetime
    field :produced_by, :string #? entity name

    has_many :items, Demo.Invoices.Item
    has_many :documents, Demo.Documents.Document
    
    embeds_many :comments, Demo.Entities.CommentEmbed
    embeds_many :product_logs, Demo.Products.ProductLogEmbed

    belongs_to :gpc_code, Demo.Products.GPCCode, type: :binary_id, on_replace: :delete 
    belongs_to :biz_category, Demo.Entities.BizCategory, type: :binary_id, on_replace: :delete
    belongs_to :entity, Demo.Entities.Entity, type: :binary_id, on_replace: :delete
    belongs_to :gab, Demo.Gabs.Gab, type: :binary_id, on_replace: :delete

    # many_to_many(
    #   :entities,
    #   Entity,
    #   # join_through: Demo.Products.AccountsProducts,
    #   join_through: "entities_products",
    #   on_replace: :delete
    # )

    timestamps()
  end

  @fields [
    :type, :name, :arrived_when, :stored_at, :managed_by, :expiration_date, :produced_by, 
    :name, :price, :quantity, :stars, :pvr, :description, :biz_category_id,
    :seller_name, :seller_id, :seller_supul_name, :seller_supul_id
  ]
  @doc false
  def changeset(product, attrs \\ %{}) do
    product
    |> cast(attrs, @fields)
    |> validate_required([])
    # |> cast_embed(:comments)
    # |> assoc_constraint(:gpc_code)
    # |> assoc_constraint(:biz_category)
  end

  def changeset_update_entities(%Product{} = product, entities) do
    product 
    |> Repo.preload(:entities)
    |> change()  \
    |> put_assoc(:entities, entities) #? many to many between users and entities
    |> Repo.update!()
  end
end
