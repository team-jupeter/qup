defmodule Demo.CertificatesTest do
  use Demo.DataCase

  alias Demo.Certificates

  describe "certificates" do
    alias Demo.Certificates.Certificate

    @valid_attrs %{issuer: "some issuer", name: "some name", valid_until: "some valid_until"}
    @update_attrs %{issuer: "some updated issuer", name: "some updated name", valid_until: "some updated valid_until"}
    @invalid_attrs %{issuer: nil, name: nil, valid_until: nil}

    def certificate_fixture(attrs \\ %{}) do
      {:ok, certificate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Certificates.create_certificate()

      certificate
    end

    test "list_certificates/0 returns all certificates" do
      certificate = certificate_fixture()
      assert Certificates.list_certificates() == [certificate]
    end

    test "get_certificate!/1 returns the certificate with given id" do
      certificate = certificate_fixture()
      assert Certificates.get_certificate!(certificate.id) == certificate
    end

    test "create_certificate/1 with valid data creates a certificate" do
      assert {:ok, %Certificate{} = certificate} = Certificates.create_certificate(@valid_attrs)
      assert certificate.issuer == "some issuer"
      assert certificate.name == "some name"
      assert certificate.valid_until == "some valid_until"
    end

    test "create_certificate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Certificates.create_certificate(@invalid_attrs)
    end

    test "update_certificate/2 with valid data updates the certificate" do
      certificate = certificate_fixture()
      assert {:ok, %Certificate{} = certificate} = Certificates.update_certificate(certificate, @update_attrs)
      assert certificate.issuer == "some updated issuer"
      assert certificate.name == "some updated name"
      assert certificate.valid_until == "some updated valid_until"
    end

    test "update_certificate/2 with invalid data returns error changeset" do
      certificate = certificate_fixture()
      assert {:error, %Ecto.Changeset{}} = Certificates.update_certificate(certificate, @invalid_attrs)
      assert certificate == Certificates.get_certificate!(certificate.id)
    end

    test "delete_certificate/1 deletes the certificate" do
      certificate = certificate_fixture()
      assert {:ok, %Certificate{}} = Certificates.delete_certificate(certificate)
      assert_raise Ecto.NoResultsError, fn -> Certificates.get_certificate!(certificate.id) end
    end

    test "change_certificate/1 returns a certificate changeset" do
      certificate = certificate_fixture()
      assert %Ecto.Changeset{} = Certificates.change_certificate(certificate)
    end
  end
end
