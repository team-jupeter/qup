defmodule Demo.MachinesTest do
  use Demo.DataCase

  alias Demo.Machines

  describe "machines" do
    alias Demo.Machines.Machine

    @valid_attrs %{name: "some name", purpose: "some purpose"}
    @update_attrs %{name: "some updated name", purpose: "some updated purpose"}
    @invalid_attrs %{name: nil, purpose: nil}

    def machine_fixture(attrs \\ %{}) do
      {:ok, machine} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Machines.create_machine()

      machine
    end

    test "list_machines/0 returns all machines" do
      machine = machine_fixture()
      assert Machines.list_machines() == [machine]
    end

    test "get_machine!/1 returns the machine with given id" do
      machine = machine_fixture()
      assert Machines.get_machine!(machine.id) == machine
    end

    test "create_machine/1 with valid data creates a machine" do
      assert {:ok, %Machine{} = machine} = Machines.create_machine(@valid_attrs)
      assert machine.name == "some name"
      assert machine.purpose == "some purpose"
    end

    test "create_machine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Machines.create_machine(@invalid_attrs)
    end

    test "update_machine/2 with valid data updates the machine" do
      machine = machine_fixture()
      assert {:ok, %Machine{} = machine} = Machines.update_machine(machine, @update_attrs)
      assert machine.name == "some updated name"
      assert machine.purpose == "some updated purpose"
    end

    test "update_machine/2 with invalid data returns error changeset" do
      machine = machine_fixture()
      assert {:error, %Ecto.Changeset{}} = Machines.update_machine(machine, @invalid_attrs)
      assert machine == Machines.get_machine!(machine.id)
    end

    test "delete_machine/1 deletes the machine" do
      machine = machine_fixture()
      assert {:ok, %Machine{}} = Machines.delete_machine(machine)
      assert_raise Ecto.NoResultsError, fn -> Machines.get_machine!(machine.id) end
    end

    test "change_machine/1 returns a machine changeset" do
      machine = machine_fixture()
      assert %Ecto.Changeset{} = Machines.change_machine(machine)
    end
  end
end
