defmodule Demo.ClinicsTest do
  use Demo.DataCase

  alias Demo.Clinics

  describe "clinics" do
    alias Demo.Clinics.Clinic

    @valid_attrs %{license_: "some license_", representative: "some representative", specialty: "some specialty"}
    @update_attrs %{license_: "some updated license_", representative: "some updated representative", specialty: "some updated specialty"}
    @invalid_attrs %{license_: nil, representative: nil, specialty: nil}

    def clinic_fixture(attrs \\ %{}) do
      {:ok, clinic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Clinics.create_clinic()

      clinic
    end

    test "list_clinics/0 returns all clinics" do
      clinic = clinic_fixture()
      assert Clinics.list_clinics() == [clinic]
    end

    test "get_clinic!/1 returns the clinic with given id" do
      clinic = clinic_fixture()
      assert Clinics.get_clinic!(clinic.id) == clinic
    end

    test "create_clinic/1 with valid data creates a clinic" do
      assert {:ok, %Clinic{} = clinic} = Clinics.create_clinic(@valid_attrs)
      assert clinic.license_ == "some license_"
      assert clinic.representative == "some representative"
      assert clinic.specialty == "some specialty"
    end

    test "create_clinic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clinics.create_clinic(@invalid_attrs)
    end

    test "update_clinic/2 with valid data updates the clinic" do
      clinic = clinic_fixture()
      assert {:ok, %Clinic{} = clinic} = Clinics.update_clinic(clinic, @update_attrs)
      assert clinic.license_ == "some updated license_"
      assert clinic.representative == "some updated representative"
      assert clinic.specialty == "some updated specialty"
    end

    test "update_clinic/2 with invalid data returns error changeset" do
      clinic = clinic_fixture()
      assert {:error, %Ecto.Changeset{}} = Clinics.update_clinic(clinic, @invalid_attrs)
      assert clinic == Clinics.get_clinic!(clinic.id)
    end

    test "delete_clinic/1 deletes the clinic" do
      clinic = clinic_fixture()
      assert {:ok, %Clinic{}} = Clinics.delete_clinic(clinic)
      assert_raise Ecto.NoResultsError, fn -> Clinics.get_clinic!(clinic.id) end
    end

    test "change_clinic/1 returns a clinic changeset" do
      clinic = clinic_fixture()
      assert %Ecto.Changeset{} = Clinics.change_clinic(clinic)
    end
  end
end
