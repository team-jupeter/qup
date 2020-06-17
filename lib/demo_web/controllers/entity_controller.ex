defmodule DemoWeb.EntityController do
  use DemoWeb, :controller
  alias Demo.Business
  alias Demo.Business.Entity

  plug :authenticate_user when action in [:new, :create]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    entities = Business.list_user_entities(current_user) 
    render(conn, "index.html", entities: entities)
  end

  def show(conn, %{"id" => id}, current_user) do
    entity = Business.get_user_entity!(current_user, id) 

    conn = conn
    |> DemoWeb.EntityAuth.entity_login(entity)

    # IO.inspect conn

    render(conn, "show.html", entity: entity)

  end

  def edit(conn, %{"id" => id}, current_user) do
    entity = Business.get_user_entity!(current_user, id) 
    changeset = Business.change_entity(entity)
    render(conn, "edit.html", entity: entity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entity" => entity_params}, current_user) do
    entity = Business.get_user_entity!(current_user, id) 

    case Business.update_entity(entity, entity_params) do
      {:ok, entity} ->
        conn
        |> put_flash(:info, "Entity updated successfully.")
        |> redirect(to: Routes.entity_path(conn, :show, entity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entity: entity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    entity = Business.get_user_entity!(current_user, id) 
    {:ok, _entity} = Business.delete_entity(entity)

    conn
    |> put_flash(:info, "Entity deleted successfully.")
    |> redirect(to: Routes.entity_path(conn, :index))
  end

  def new(conn, _params, _current_user) do
    changeset = Business.change_entity(%Entity{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"entity" => entity_params}, current_user) do
    case Business.create_entity(current_user, entity_params) do
      {:ok, entity} ->
        conn
        |> put_flash(:info, "Entity created successfully.")
        |> redirect(to: Routes.entity_path(conn, :show, entity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
