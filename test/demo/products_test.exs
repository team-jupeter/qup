defmodule Demo.ProductsTest do
  use Demo.DataCase

  alias Demo.Products

  describe "products" do
    alias Demo.Business.Product

    @valid_attrs %{comments: "some comments", gopang_fee: "some gopang_fee", gpc_code: "some gpc_code", insurance: "some insurance", name: "some name", price: "120.5", stars: "120.5", tax: "120.5"}
    @update_attrs %{comments: "some updated comments", gopang_fee: "some updated gopang_fee", gpc_code: "some updated gpc_code", insurance: "some updated insurance", name: "some updated name", price: "456.7", stars: "456.7", tax: "456.7"}
    @invalid_attrs %{comments: nil, gopang_fee: nil, gpc_code: nil, insurance: nil, name: nil, price: nil, stars: nil, tax: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Products.create_product(@valid_attrs)
      assert product.comments == "some comments"
      assert product.gopang_fee == "some gopang_fee"
      assert product.gpc_code == "some gpc_code"
      assert product.insurance == "some insurance"
      assert product.name == "some name"
      assert product.price == Decimal.new("120.5")
      assert product.stars == Decimal.new("120.5")
      assert product.tax == Decimal.new("120.5")
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Products.update_product(product, @update_attrs)
      assert product.comments == "some updated comments"
      assert product.gopang_fee == "some updated gopang_fee"
      assert product.gpc_code == "some updated gpc_code"
      assert product.insurance == "some updated insurance"
      assert product.name == "some updated name"
      assert product.price == Decimal.new("456.7")
      assert product.stars == Decimal.new("456.7")
      assert product.tax == Decimal.new("456.7")
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
