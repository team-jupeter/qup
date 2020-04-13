defmodule Demo.TradesTest do
  use Demo.DataCase

  alias Demo.Trades

  describe "products" do
    alias Demo.Products.Product

    @valid_attrs %{category: "some category", name: "some name"}
    @update_attrs %{category: "some updated category", name: "some updated name"}
    @invalid_attrs %{category: nil, name: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trades.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Trades.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Trades.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Trades.create_product(@valid_attrs)
      assert product.category == "some category"
      assert product.name == "some name"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trades.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Trades.update_product(product, @update_attrs)
      assert product.category == "some updated category"
      assert product.name == "some updated name"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Trades.update_product(product, @invalid_attrs)
      assert product == Trades.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Trades.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Trades.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Trades.change_product(product)
    end
  end

  describe "sellers" do
    alias Demo.Trades.Seller

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def seller_fixture(attrs \\ %{}) do
      {:ok, seller} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trades.create_seller()

      seller
    end

    test "list_sellers/0 returns all sellers" do
      seller = seller_fixture()
      assert Trades.list_sellers() == [seller]
    end

    test "get_seller!/1 returns the seller with given id" do
      seller = seller_fixture()
      assert Trades.get_seller!(seller.id) == seller
    end

    test "create_seller/1 with valid data creates a seller" do
      assert {:ok, %Seller{} = seller} = Trades.create_seller(@valid_attrs)
      assert seller.name == "some name"
    end

    test "create_seller/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trades.create_seller(@invalid_attrs)
    end

    test "update_seller/2 with valid data updates the seller" do
      seller = seller_fixture()
      assert {:ok, %Seller{} = seller} = Trades.update_seller(seller, @update_attrs)
      assert seller.name == "some updated name"
    end

    test "update_seller/2 with invalid data returns error changeset" do
      seller = seller_fixture()
      assert {:error, %Ecto.Changeset{}} = Trades.update_seller(seller, @invalid_attrs)
      assert seller == Trades.get_seller!(seller.id)
    end

    test "delete_seller/1 deletes the seller" do
      seller = seller_fixture()
      assert {:ok, %Seller{}} = Trades.delete_seller(seller)
      assert_raise Ecto.NoResultsError, fn -> Trades.get_seller!(seller.id) end
    end

    test "change_seller/1 returns a seller changeset" do
      seller = seller_fixture()
      assert %Ecto.Changeset{} = Trades.change_seller(seller)
    end
  end

  describe "buyers" do
    alias Demo.Trades.Buyer

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def buyer_fixture(attrs \\ %{}) do
      {:ok, buyer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trades.create_buyer()

      buyer
    end

    test "list_buyers/0 returns all buyers" do
      buyer = buyer_fixture()
      assert Trades.list_buyers() == [buyer]
    end

    test "get_buyer!/1 returns the buyer with given id" do
      buyer = buyer_fixture()
      assert Trades.get_buyer!(buyer.id) == buyer
    end

    test "create_buyer/1 with valid data creates a buyer" do
      assert {:ok, %Buyer{} = buyer} = Trades.create_buyer(@valid_attrs)
      assert buyer.name == "some name"
    end

    test "create_buyer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trades.create_buyer(@invalid_attrs)
    end

    test "update_buyer/2 with valid data updates the buyer" do
      buyer = buyer_fixture()
      assert {:ok, %Buyer{} = buyer} = Trades.update_buyer(buyer, @update_attrs)
      assert buyer.name == "some updated name"
    end

    test "update_buyer/2 with invalid data returns error changeset" do
      buyer = buyer_fixture()
      assert {:error, %Ecto.Changeset{}} = Trades.update_buyer(buyer, @invalid_attrs)
      assert buyer == Trades.get_buyer!(buyer.id)
    end

    test "delete_buyer/1 deletes the buyer" do
      buyer = buyer_fixture()
      assert {:ok, %Buyer{}} = Trades.delete_buyer(buyer)
      assert_raise Ecto.NoResultsError, fn -> Trades.get_buyer!(buyer.id) end
    end

    test "change_buyer/1 returns a buyer changeset" do
      buyer = buyer_fixture()
      assert %Ecto.Changeset{} = Trades.change_buyer(buyer)
    end
  end
end
