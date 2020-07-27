defmodule Demo.EventsTest do
  use Demo.DataCase

  alias Demo.Events

  describe "events" do
    alias Demo.Events.Event

    @valid_attrs %{how: "some how", what: "some what", when: "some when", where: "some where", who: "some who", why: "some why"}
    @update_attrs %{how: "some updated how", what: "some updated what", when: "some updated when", where: "some updated where", who: "some updated who", why: "some updated why"}
    @invalid_attrs %{how: nil, what: nil, when: nil, where: nil, who: nil, why: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs  
        |> Enum.into(@valid_attrs)
        |> Events.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Events.create_event(@valid_attrs)
      assert event.how == "some how"
      assert event.what == "some what"
      assert event.when == "some when"
      assert event.where == "some where"
      assert event.who == "some who"
      assert event.why == "some why"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Events.update_event(event, @update_attrs)
      assert event.how == "some updated how"
      assert event.what == "some updated what"
      assert event.when == "some updated when"
      assert event.where == "some updated where"
      assert event.who == "some updated who"
      assert event.why == "some updated why"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
