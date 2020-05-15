defmodule Demo.LicensesTest do
  use Demo.DataCase

  alias Demo.Licenses

  describe "licenses" do
    alias Demo.Licenses.License

    @valid_attrs %{issued_at: "some issued_at", issued_by: "some issued_by", issued_to: "some issued_to", name: "some name"}
    @update_attrs %{issued_at: "some updated issued_at", issued_by: "some updated issued_by", issued_to: "some updated issued_to", name: "some updated name"}
    @invalid_attrs %{issued_at: nil, issued_by: nil, issued_to: nil, name: nil}

    def license_fixture(attrs \\ %{}) do
      {:ok, license} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Licenses.create_license()

      license
    end

    test "list_licenses/0 returns all licenses" do
      license = license_fixture()
      assert Licenses.list_licenses() == [license]
    end

    test "get_license!/1 returns the license with given id" do
      license = license_fixture()
      assert Licenses.get_license!(license.id) == license
    end

    test "create_license/1 with valid data creates a license" do
      assert {:ok, %License{} = license} = Licenses.create_license(@valid_attrs)
      assert license.issued_at == "some issued_at"
      assert license.issued_by == "some issued_by"
      assert license.issued_to == "some issued_to"
      assert license.name == "some name"
    end

    test "create_license/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Licenses.create_license(@invalid_attrs)
    end

    test "update_license/2 with valid data updates the license" do
      license = license_fixture()
      assert {:ok, %License{} = license} = Licenses.update_license(license, @update_attrs)
      assert license.issued_at == "some updated issued_at"
      assert license.issued_by == "some updated issued_by"
      assert license.issued_to == "some updated issued_to"
      assert license.name == "some updated name"
    end

    test "update_license/2 with invalid data returns error changeset" do
      license = license_fixture()
      assert {:error, %Ecto.Changeset{}} = Licenses.update_license(license, @invalid_attrs)
      assert license == Licenses.get_license!(license.id)
    end

    test "delete_license/1 deletes the license" do
      license = license_fixture()
      assert {:ok, %License{}} = Licenses.delete_license(license)
      assert_raise Ecto.NoResultsError, fn -> Licenses.get_license!(license.id) end
    end

    test "change_license/1 returns a license changeset" do
      license = license_fixture()
      assert %Ecto.Changeset{} = Licenses.change_license(license)
    end
  end
end
