defmodule DemoWeb.EntityController do
  use DemoWeb, :controller
  alias Demo.Entities
  alias Demo.Entities.Entity  

  # plug :authenticate_user when action in [:new, :create]
  plug :load_biz_categories when action in [:new, :create, :edit, :update]

  defp load_biz_categories(conn, _) do
    assign(conn, :biz_categories, Entities.list_alphabetical_biz_categories())
  end 
 
  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
 
  def index(conn, _params, current_user) do
    entities = Entities.list_user_entities(current_user) 
    render(conn, "index.html", entities: entities)
  end
   
  def show(conn, %{"id" => id}, current_user) do
    entity = Entities.get_user_entity!(current_user, id) 

    conn = conn
    |> DemoWeb.EntityAuth.entity_login(entity)

    render(conn, "show.html", entity: entity)

  end

  def edit(conn, %{"id" => id}, current_user) do
    entity = Entities.get_user_entity!(current_user, id) 
    changeset = Entities.change_entity(entity)
    render(conn, "edit.html", entity: entity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "entity" => entity_params}, current_user) do
    entity = Entities.get_user_entity!(current_user, id) 

    case Entities.update_entity(entity, entity_params) do
      {:ok, entity} ->
        conn
        |> put_flash(:info, "Entity updated successfully.")
        |> redirect(to: Routes.entity_path(conn, :show, entity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", entity: entity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    entity = Entities.get_user_entity!(current_user, id) 
    {:ok, _entity} = Entities.delete_entity(entity)

    conn
    |> put_flash(:info, "Entity deleted successfully.")
    |> redirect(to: Routes.entity_path(conn, :index))
  end
 
  def new(conn, _params, _current_user) do
    IO.puts "entity.new"
    changeset = Entities.create_entity(%Entity{}) 
    render(conn, "new.html", changeset: changeset)
  end

  def create_default_entity(conn, %{"entity" => entity_params}, current_user) do
    case Entities.create_default_entity(current_user, entity_params) do
      {:ok, entity} ->
        update_user(current_user, entity)

        conn
        |> put_flash(:info, "Entity created successfully.")
        |> redirect(to: Routes.entity_path(conn, :show, entity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp update_user(user, entity) do
    Demo.Accounts.update_user(user, %{default_entity_id: entity.id})  
  end

  def create_private_entity(conn, %{"entity" => entity_params}, current_user) do
    case Entities.create_private_entity(current_user, entity_params) do
      {:ok, entity} ->
        conn
        |> put_flash(:info, "Entity created successfully.")
        |> redirect(to: Routes.entity_path(conn, :show, entity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def create_public_entity(conn, %{"entity" => entity_params}, current_user) do
    case Entities.create_public_entity(current_user, entity_params) do
      {:ok, entity} ->
        conn
        |> put_flash(:info, "Entity created successfully.")
        |> redirect(to: Routes.entity_path(conn, :show, entity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
