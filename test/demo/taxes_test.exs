defmodule Demo.TaxesTest do
  use Demo.DataCase

  alias Demo.Taxes

  describe "taxes" do
    alias Demo.Taxes.Tax

    @valid_attrs %{name: "some name", nationality: "some nationality"}
    @update_attrs %{name: "some updated name", nationality: "some updated nationality"}
    @invalid_attrs %{name: nil, nationality: nil}

    def tax_fixture(attrs \\ %{}) do
      {:ok, tax} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Taxes.create_tax()

      tax
    end

    test "list_taxes/0 returns all taxes" do
      tax = tax_fixture()
      assert Taxes.list_taxes() == [tax]
    end

    test "get_tax!/1 returns the tax with given id" do
      tax = tax_fixture()
      assert Taxes.get_tax!(tax.id) == tax
    end

    test "create_tax/1 with valid data creates a tax" do
      assert {:ok, %Tax{} = tax} = Taxes.create_tax(@valid_attrs)
      assert tax.name == "some name"
      assert tax.nationality == "some nationality"
    end

    test "create_tax/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxes.create_tax(@invalid_attrs)
    end

    test "update_tax/2 with valid data updates the tax" do
      tax = tax_fixture()
      assert {:ok, %Tax{} = tax} = Taxes.update_tax(tax, @update_attrs)
      assert tax.name == "some updated name"
      assert tax.nationality == "some updated nationality"
    end

    test "update_tax/2 with invalid data returns error changeset" do
      tax = tax_fixture()
      assert {:error, %Ecto.Changeset{}} = Taxes.update_tax(tax, @invalid_attrs)
      assert tax == Taxes.get_tax!(tax.id)
    end

    test "delete_tax/1 deletes the tax" do
      tax = tax_fixture()
      assert {:ok, %Tax{}} = Taxes.delete_tax(tax)
      assert_raise Ecto.NoResultsError, fn -> Taxes.get_tax!(tax.id) end
    end

    test "change_tax/1 returns a tax changeset" do
      tax = tax_fixture()
      assert %Ecto.Changeset{} = Taxes.change_tax(tax)
    end
  end
end
