defmodule Demo.Products.EntitiesProducts do
    @moduledoc """
    This module is used to test:
      * Many to many associations join_through with schema
    """
    use Ecto.Schema
    # import Ecto.Changeset
    @primary_key {:id, :binary_id, autogenerate: true}
    @foreign_key_type :binary_id
  
    schema "entities_products" do
      belongs_to :entity, Demo.Entities.Entity, type: :binary_id
      belongs_to :product, Demo.Entities.Product, type: :binary_id
      timestamps()
    end
  end