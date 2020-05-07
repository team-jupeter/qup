defmodule Demo.ProducersTest do
  use Demo.DataCase

  alias Demo.Producers

  describe "producers" do
    alias Demo.Producers.Producer

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def producer_fixture(attrs \\ %{}) do
      {:ok, producer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Producers.create_producer()

      producer
    end

    test "list_producers/0 returns all producers" do
      producer = producer_fixture()
      assert Producers.list_producers() == [producer]
    end

    test "get_producer!/1 returns the producer with given id" do
      producer = producer_fixture()
      assert Producers.get_producer!(producer.id) == producer
    end

    test "create_producer/1 with valid data creates a producer" do
      assert {:ok, %Producer{} = producer} = Producers.create_producer(@valid_attrs)
      assert producer.name == "some name"
    end

    test "create_producer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Producers.create_producer(@invalid_attrs)
    end

    test "update_producer/2 with valid data updates the producer" do
      producer = producer_fixture()
      assert {:ok, %Producer{} = producer} = Producers.update_producer(producer, @update_attrs)
      assert producer.name == "some updated name"
    end

    test "update_producer/2 with invalid data returns error changeset" do
      producer = producer_fixture()
      assert {:error, %Ecto.Changeset{}} = Producers.update_producer(producer, @invalid_attrs)
      assert producer == Producers.get_producer!(producer.id)
    end

    test "delete_producer/1 deletes the producer" do
      producer = producer_fixture()
      assert {:ok, %Producer{}} = Producers.delete_producer(producer)
      assert_raise Ecto.NoResultsError, fn -> Producers.get_producer!(producer.id) end
    end

    test "change_producer/1 returns a producer changeset" do
      producer = producer_fixture()
      assert %Ecto.Changeset{} = Producers.change_producer(producer)
    end
  end
end
