defmodule DemoWeb.CertificateControllerTest do
  use DemoWeb.ConnCase

  alias Demo.Certificates

  @create_attrs %{auth_code: "some auth_code", granted_to: "some granted_to", issued_by: "some issued_by", issued_on: "some issued_on", name: "some name", valid_until: "some valid_until"}
  @update_attrs %{auth_code: "some updated auth_code", granted_to: "some updated granted_to", issued_by: "some updated issued_by", issued_on: "some updated issued_on", name: "some updated name", valid_until: "some updated valid_until"}
  @invalid_attrs %{auth_code: nil, granted_to: nil, issued_by: nil, issued_on: nil, name: nil, valid_until: nil}

  def fixture(:certificate) do
    {:ok, certificate} = Certificates.create_certificate(@create_attrs)
    certificate
  end

  describe "index" do
    test "lists all certificates", %{conn: conn} do
      conn = get(conn, Routes.certificate_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Certificates"
    end
  end

  describe "new certificate" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.certificate_path(conn, :new))
      assert html_response(conn, 200) =~ "New Certificate"
    end
  end

  describe "create certificate" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.certificate_path(conn, :create), certificate: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.certificate_path(conn, :show, id)

      conn = get(conn, Routes.certificate_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Certificate"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.certificate_path(conn, :create), certificate: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Certificate"
    end
  end

  describe "edit certificate" do
    setup [:create_certificate]

    test "renders form for editing chosen certificate", %{conn: conn, certificate: certificate} do
      conn = get(conn, Routes.certificate_path(conn, :edit, certificate))
      assert html_response(conn, 200) =~ "Edit Certificate"
    end
  end

  describe "update certificate" do
    setup [:create_certificate]

    test "redirects when data is valid", %{conn: conn, certificate: certificate} do
      conn = put(conn, Routes.certificate_path(conn, :update, certificate), certificate: @update_attrs)
      assert redirected_to(conn) == Routes.certificate_path(conn, :show, certificate)

      conn = get(conn, Routes.certificate_path(conn, :show, certificate))
      assert html_response(conn, 200) =~ "some updated auth_code"
    end

    test "renders errors when data is invalid", %{conn: conn, certificate: certificate} do
      conn = put(conn, Routes.certificate_path(conn, :update, certificate), certificate: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Certificate"
    end
  end

  describe "delete certificate" do
    setup [:create_certificate]

    test "deletes chosen certificate", %{conn: conn, certificate: certificate} do
      conn = delete(conn, Routes.certificate_path(conn, :delete, certificate))
      assert redirected_to(conn) == Routes.certificate_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.certificate_path(conn, :show, certificate))
      end
    end
  end

  defp create_certificate(_) do
    certificate = fixture(:certificate)
    {:ok, certificate: certificate}
  end
end
