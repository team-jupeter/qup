defmodule DemoWeb.WeddingController do
  use DemoWeb, :controller

  alias Demo.Weddings
  alias Demo.Weddings.Wedding
  alias Demo.Events

  def index(conn, _params) do
    weddings = Weddings.list_weddings()
    render(conn, "index.html", weddings: weddings)
  end

  def new(conn, _params) do
    changeset = Weddings.change_wedding(%Wedding{})
    render(conn, "new.html", changeset: changeset)
  end 

  #? hard coded bride_private_key, groom_private_key
  bride_private_key = ExPublicKey.load!("./keys/lee_private_key.pem")
  groom_private_key = ExPublicKey.load!("./keys/sung_private_key.pem")

  def create(conn, %{"wedding" => wedding_params}, bride_private_key, groom_private_key) do
    
    case Weddings.create_wedding(wedding_params) do
      {:ok, wedding} ->
        Events.create_event(wedding, bride_private_key, groom_private_key)

        conn
        |> put_flash(:info, "Wedding created successfully.")
        |> redirect(to: Routes.wedding_path(conn, :show, wedding))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    wedding = Weddings.get_wedding!(id)
    render(conn, "show.html", wedding: wedding)
  end

  def edit(conn, %{"id" => id}) do
    wedding = Weddings.get_wedding!(id)
    changeset = Weddings.change_wedding(wedding)
    render(conn, "edit.html", wedding: wedding, changeset: changeset)
  end

  def update(conn, %{"id" => id, "wedding" => wedding_params}) do
    wedding = Weddings.get_wedding!(id)

    case Weddings.update_wedding(wedding, wedding_params) do
      {:ok, wedding} ->
        conn
        |> put_flash(:info, "Wedding updated successfully.")
        |> redirect(to: Routes.wedding_path(conn, :show, wedding))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", wedding: wedding, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    wedding = Weddings.get_wedding!(id)
    {:ok, _wedding} = Weddings.delete_wedding(wedding)

    conn
    |> put_flash(:info, "Wedding deleted successfully.")
    |> redirect(to: Routes.wedding_path(conn, :index))
  end
end
