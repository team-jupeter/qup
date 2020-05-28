defmodule Demo.PatentsTest do
  use Demo.DataCase

  alias Demo.Patents

  describe "patents" do
    alias Demo.Patents.Patent

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def patent_fixture(attrs \\ %{}) do
      {:ok, patent} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Patents.create_patent()

      patent
    end

    test "list_patents/0 returns all patents" do
      patent = patent_fixture()
      assert Patents.list_patents() == [patent]
    end

    test "get_patent!/1 returns the patent with given id" do
      patent = patent_fixture()
      assert Patents.get_patent!(patent.id) == patent
    end

    test "create_patent/1 with valid data creates a patent" do
      assert {:ok, %Patent{} = patent} = Patents.create_patent(@valid_attrs)
    end

    test "create_patent/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Patents.create_patent(@invalid_attrs)
    end

    test "update_patent/2 with valid data updates the patent" do
      patent = patent_fixture()
      assert {:ok, %Patent{} = patent} = Patents.update_patent(patent, @update_attrs)
    end

    test "update_patent/2 with invalid data returns error changeset" do
      patent = patent_fixture()
      assert {:error, %Ecto.Changeset{}} = Patents.update_patent(patent, @invalid_attrs)
      assert patent == Patents.get_patent!(patent.id)
    end

    test "delete_patent/1 deletes the patent" do
      patent = patent_fixture()
      assert {:ok, %Patent{}} = Patents.delete_patent(patent)
      assert_raise Ecto.NoResultsError, fn -> Patents.get_patent!(patent.id) end
    end

    test "change_patent/1 returns a patent changeset" do
      patent = patent_fixture()
      assert %Ecto.Changeset{} = Patents.change_patent(patent)
    end
  end
end
