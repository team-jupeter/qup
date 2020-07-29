defmodule DemoWeb.FamilyController do
  use DemoWeb, :controller

  alias Demo.Repo
  alias Demo.Families
  alias Demo.Families.Family
  alias Demo.Accounts.User
  alias Demo.Entities.Entity

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, _params, current_user) do
    default_entity = Repo.get!(Entity, current_user.default_entity_id)
    family_entity = Families.get_family_entity(default_entity) 

    IO.inspect "family_entity.id"
    IO.inspect family_entity.id

    render(conn, "index.html", family_entity: family_entity)
  end

  def show(conn, _, %User{} = current_user) do
    family = Families.get_user_family!(current_user)

    render(conn, "show.html", family: family)
  end

  # def show(conn, _, %Entity{} = current_entity) do
  #   family = Families.get_entity_family!(current_entity)

  #   render(conn, "show.html", family: family)
  # end

  def edit(conn, %{"id" => _id}, current_user) do
    family = Families.get_user_family!(current_user)
    changeset = Families.change_family(family)
    render(conn, "edit.html", family: family, changeset: changeset)
  end

  def update(conn, %{"id" => _id, "family" => family_params}, current_user) do
    family = Families.get_user_family!(current_user)

    case Families.update_family(family, family_params) do
      {:ok, family} ->
        conn
        |> put_flash(:info, "Family updated successfully.")
        |> redirect(to: Routes.family_path(conn, :show, family))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", family: family, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => _id}, current_user) do
    family = Families.get_user_family!(current_user)
    {:ok, _family} = Families.delete_family(family)

    conn
    |> put_flash(:info, "Family deleted successfully.")
    |> redirect(to: Routes.family_path(conn, :index))
  end

  def new(conn, _params, _current_user) do
    IO.puts("family.new")
    changeset = Families.new_family(%Family{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"family" => family_params}) do
    case Families.create_family(family_params) do
      {:ok, family} ->
        conn
        |> put_flash(:info, "Family created successfully.")
        |> redirect(to: Routes.family_path(conn, :show, family))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end


end
