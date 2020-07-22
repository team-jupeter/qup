defmodule Demo.Entities.BizCategory do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "biz_categories" do
    field :standard, :string 
    field :name, :string
    field :code, :string

    has_many :entities, Demo.Entities.Entity
    has_many :products, Demo.Entities.Product
    
    timestamps()
  end

  @doc false
  def changeset(biz_category, attrs) do
    biz_category
    |> cast(attrs, [:standard, :code, :name])
    |> validate_required([:standard, :code, :name])
  end

  import Ecto.Query

  def alphabetical(query) do
    from c in query, order_by: c.name
  end
end
