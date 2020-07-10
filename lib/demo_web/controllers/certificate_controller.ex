defmodule DemoWeb.CertificateController do
  use DemoWeb, :controller
 
  alias Demo.Certificates
  alias Demo.Certificates.Certificate

  def index(conn, _params) do
    certificates = Certificates.list_certificates()
    render(conn, "index.html", certificates: certificates)
  end

  def new(conn, _params) do
    changeset = Certificates.change_certificate(%Certificate{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"certificate" => certificate_params}) do
    case Certificates.create_certificate(certificate_params) do
      {:ok, certificate} ->
        conn
        |> put_flash(:info, "Certificate created successfully.")
        |> redirect(to: Routes.certificate_path(conn, :show, certificate))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    certificate = Certificates.get_certificate!(id)
    render(conn, "show.html", certificate: certificate)
  end

  def edit(conn, %{"id" => id}) do
    certificate = Certificates.get_certificate!(id)
    changeset = Certificates.change_certificate(certificate)
    render(conn, "edit.html", certificate: certificate, changeset: changeset)
  end

  def update(conn, %{"id" => id, "certificate" => certificate_params}) do
    certificate = Certificates.get_certificate!(id)

    case Certificates.update_certificate(certificate, certificate_params) do
      {:ok, certificate} ->
        conn
        |> put_flash(:info, "Certificate updated successfully.")
        |> redirect(to: Routes.certificate_path(conn, :show, certificate))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", certificate: certificate, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    certificate = Certificates.get_certificate!(id)
    {:ok, _certificate} = Certificates.delete_certificate(certificate)

    conn
    |> put_flash(:info, "Certificate deleted successfully.")
    |> redirect(to: Routes.certificate_path(conn, :index))
  end
end
