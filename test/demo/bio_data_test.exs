defmodule Demo.BioDataTest do
  use Demo.DataCase

  alias Demo.BioData

  describe "usweight" do
    alias Demo.BioData.BioDatum

    @valid_attrs %{blood_pressure: "some blood_pressure", blood_sugar: "some blood_sugar", blood_type: "some blood_type", dna: "some dna", fingerprint: "some fingerprint", footprint: "some footprint", health_status: "some health_status", iris_pattern: "some iris_pattern", medic_treatments: "some medic_treatments", vision: "some vision", weight: "some weight"}
    @update_attrs %{blood_pressure: "some updated blood_pressure", blood_sugar: "some updated blood_sugar", blood_type: "some updated blood_type", dna: "some updated dna", fingerprint: "some updated fingerprint", footprint: "some updated footprint", health_status: "some updated health_status", iris_pattern: "some updated iris_pattern", medic_treatments: "some updated medic_treatments", vision: "some updated vision", weight: "some updated weight"}
    @invalid_attrs %{blood_pressure: nil, blood_sugar: nil, blood_type: nil, dna: nil, fingerprint: nil, footprint: nil, health_status: nil, iris_pattern: nil, medic_treatments: nil, vision: nil, weight: nil}

    def bio_datum_fixture(attrs \\ %{}) do
      {:ok, bio_datum} =
        attrs
        |> Enum.into(@valid_attrs)
        |> BioData.create_bio_datum()

      bio_datum
    end

    test "list_usweight/0 returns all usweight" do
      bio_datum = bio_datum_fixture()
      assert BioData.list_usweight() == [bio_datum]
    end

    test "get_bio_datum!/1 returns the bio_datum with given id" do
      bio_datum = bio_datum_fixture()
      assert BioData.get_bio_datum!(bio_datum.id) == bio_datum
    end

    test "create_bio_datum/1 with valid data creates a bio_datum" do
      assert {:ok, %BioDatum{} = bio_datum} = BioData.create_bio_datum(@valid_attrs)
      assert bio_datum.blood_pressure == "some blood_pressure"
      assert bio_datum.blood_sugar == "some blood_sugar"
      assert bio_datum.blood_type == "some blood_type"
      assert bio_datum.dna == "some dna"
      assert bio_datum.fingerprint == "some fingerprint"
      assert bio_datum.footprint == "some footprint"
      assert bio_datum.health_status == "some health_status"
      assert bio_datum.iris_pattern == "some iris_pattern"
      assert bio_datum.medic_treatments == "some medic_treatments"
      assert bio_datum.vision == "some vision"
      assert bio_datum.weight == "some weight"
    end

    test "create_bio_datum/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BioData.create_bio_datum(@invalid_attrs)
    end

    test "update_bio_datum/2 with valid data updates the bio_datum" do
      bio_datum = bio_datum_fixture()
      assert {:ok, %BioDatum{} = bio_datum} = BioData.update_bio_datum(bio_datum, @update_attrs)
      assert bio_datum.blood_pressure == "some updated blood_pressure"
      assert bio_datum.blood_sugar == "some updated blood_sugar"
      assert bio_datum.blood_type == "some updated blood_type"
      assert bio_datum.dna == "some updated dna"
      assert bio_datum.fingerprint == "some updated fingerprint"
      assert bio_datum.footprint == "some updated footprint"
      assert bio_datum.health_status == "some updated health_status"
      assert bio_datum.iris_pattern == "some updated iris_pattern"
      assert bio_datum.medic_treatments == "some updated medic_treatments"
      assert bio_datum.vision == "some updated vision"
      assert bio_datum.weight == "some updated weight"
    end

    test "update_bio_datum/2 with invalid data returns error changeset" do
      bio_datum = bio_datum_fixture()
      assert {:error, %Ecto.Changeset{}} = BioData.update_bio_datum(bio_datum, @invalid_attrs)
      assert bio_datum == BioData.get_bio_datum!(bio_datum.id)
    end

    test "delete_bio_datum/1 deletes the bio_datum" do
      bio_datum = bio_datum_fixture()
      assert {:ok, %BioDatum{}} = BioData.delete_bio_datum(bio_datum)
      assert_raise Ecto.NoResultsError, fn -> BioData.get_bio_datum!(bio_datum.id) end
    end

    test "change_bio_datum/1 returns a bio_datum changeset" do
      bio_datum = bio_datum_fixture()
      assert %Ecto.Changeset{} = BioData.change_bio_datum(bio_datum)
    end
  end
end
