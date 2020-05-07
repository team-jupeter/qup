defmodule Demo.ColorCodesTest do
  use Demo.DataCase

  alias Demo.ColorCodes

  describe "color_codes" do
    alias Demo.ColorCodes.ColorCode

    @valid_attrs %{block_10: "some block_10", block_11: "some block_11", block_12: "some block_12", block_13: "some block_13", block_14: "some block_14", block_15: "some block_15", block_16: "some block_16", block_17: "some block_17", block_18: "some block_18", block_19: "some block_19", block_20: "some block_20", block_4: "some block_4", block_5: "some block_5", block_6: "some block_6", block_7: "some block_7", block_8: "some block_8", block_9: "some block_9", blok_1: "some blok_1", blok_2: "some blok_2", blok_3: "some blok_3"}
    @update_attrs %{block_10: "some updated block_10", block_11: "some updated block_11", block_12: "some updated block_12", block_13: "some updated block_13", block_14: "some updated block_14", block_15: "some updated block_15", block_16: "some updated block_16", block_17: "some updated block_17", block_18: "some updated block_18", block_19: "some updated block_19", block_20: "some updated block_20", block_4: "some updated block_4", block_5: "some updated block_5", block_6: "some updated block_6", block_7: "some updated block_7", block_8: "some updated block_8", block_9: "some updated block_9", blok_1: "some updated blok_1", blok_2: "some updated blok_2", blok_3: "some updated blok_3"}
    @invalid_attrs %{block_10: nil, block_11: nil, block_12: nil, block_13: nil, block_14: nil, block_15: nil, block_16: nil, block_17: nil, block_18: nil, block_19: nil, block_20: nil, block_4: nil, block_5: nil, block_6: nil, block_7: nil, block_8: nil, block_9: nil, blok_1: nil, blok_2: nil, blok_3: nil}

    def color_code_fixture(attrs \\ %{}) do
      {:ok, color_code} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ColorCodes.create_color_code()

      color_code
    end

    test "list_color_codes/0 returns all color_codes" do
      color_code = color_code_fixture()
      assert ColorCodes.list_color_codes() == [color_code]
    end

    test "get_color_code!/1 returns the color_code with given id" do
      color_code = color_code_fixture()
      assert ColorCodes.get_color_code!(color_code.id) == color_code
    end

    test "create_color_code/1 with valid data creates a color_code" do
      assert {:ok, %ColorCode{} = color_code} = ColorCodes.create_color_code(@valid_attrs)
      assert color_code.block_10 == "some block_10"
      assert color_code.block_11 == "some block_11"
      assert color_code.block_12 == "some block_12"
      assert color_code.block_13 == "some block_13"
      assert color_code.block_14 == "some block_14"
      assert color_code.block_15 == "some block_15"
      assert color_code.block_16 == "some block_16"
      assert color_code.block_17 == "some block_17"
      assert color_code.block_18 == "some block_18"
      assert color_code.block_19 == "some block_19"
      assert color_code.block_20 == "some block_20"
      assert color_code.block_4 == "some block_4"
      assert color_code.block_5 == "some block_5"
      assert color_code.block_6 == "some block_6"
      assert color_code.block_7 == "some block_7"
      assert color_code.block_8 == "some block_8"
      assert color_code.block_9 == "some block_9"
      assert color_code.blok_1 == "some blok_1"
      assert color_code.blok_2 == "some blok_2"
      assert color_code.blok_3 == "some blok_3"
    end

    test "create_color_code/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ColorCodes.create_color_code(@invalid_attrs)
    end

    test "update_color_code/2 with valid data updates the color_code" do
      color_code = color_code_fixture()
      assert {:ok, %ColorCode{} = color_code} = ColorCodes.update_color_code(color_code, @update_attrs)
      assert color_code.block_10 == "some updated block_10"
      assert color_code.block_11 == "some updated block_11"
      assert color_code.block_12 == "some updated block_12"
      assert color_code.block_13 == "some updated block_13"
      assert color_code.block_14 == "some updated block_14"
      assert color_code.block_15 == "some updated block_15"
      assert color_code.block_16 == "some updated block_16"
      assert color_code.block_17 == "some updated block_17"
      assert color_code.block_18 == "some updated block_18"
      assert color_code.block_19 == "some updated block_19"
      assert color_code.block_20 == "some updated block_20"
      assert color_code.block_4 == "some updated block_4"
      assert color_code.block_5 == "some updated block_5"
      assert color_code.block_6 == "some updated block_6"
      assert color_code.block_7 == "some updated block_7"
      assert color_code.block_8 == "some updated block_8"
      assert color_code.block_9 == "some updated block_9"
      assert color_code.blok_1 == "some updated blok_1"
      assert color_code.blok_2 == "some updated blok_2"
      assert color_code.blok_3 == "some updated blok_3"
    end

    test "update_color_code/2 with invalid data returns error changeset" do
      color_code = color_code_fixture()
      assert {:error, %Ecto.Changeset{}} = ColorCodes.update_color_code(color_code, @invalid_attrs)
      assert color_code == ColorCodes.get_color_code!(color_code.id)
    end

    test "delete_color_code/1 deletes the color_code" do
      color_code = color_code_fixture()
      assert {:ok, %ColorCode{}} = ColorCodes.delete_color_code(color_code)
      assert_raise Ecto.NoResultsError, fn -> ColorCodes.get_color_code!(color_code.id) end
    end

    test "change_color_code/1 returns a color_code changeset" do
      color_code = color_code_fixture()
      assert %Ecto.Changeset{} = ColorCodes.change_color_code(color_code)
    end
  end
end
