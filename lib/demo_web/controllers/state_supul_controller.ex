defmodule DemoWeb.StateSupulController do
  use DemoWeb, :controller

  alias Demo.StateSupuls 
  alias Demo.StateSupuls.StateSupul

  def index(conn, _params) do
    state_supuls = StateSupuls.list_state_supuls()
    render(conn, "index.html", state_supuls: state_supuls)
  end

  def new(conn, _params) do
    changeset = StateSupuls.change_state_supul(%StateSupul{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"state_supul" => state_supul_params}) do
    case StateSupuls.create_state_supul(state_supul_params) do
      {:ok, state_supul} ->
        conn
        |> put_flash(:info, "State supul created successfully.")
        |> redirect(to: Routes.state_supul_path(conn, :show, state_supul))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    state_supul = StateSupuls.get_state_supul!(id)
    render(conn, "show.html", state_supul: state_supul)
  end

  def edit(conn, %{"id" => id}) do
    state_supul = StateSupuls.get_state_supul!(id)
    changeset = StateSupuls.change_state_supul(state_supul)
    render(conn, "edit.html", state_supul: state_supul, changeset: changeset)
  end

  def update(conn, %{"id" => id, "state_supul" => state_supul_params}) do
    state_supul = StateSupuls.get_state_supul!(id)

    case StateSupuls.update_state_supul(state_supul, state_supul_params) do
      {:ok, state_supul} ->
        conn
        |> put_flash(:info, "State supul updated successfully.")
        |> redirect(to: Routes.state_supul_path(conn, :show, state_supul))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", state_supul: state_supul, changeset: changeset)
    end
  end

  # def delete(conn, %{"id" => id}) do
  #   state_supul = StateSupuls.get_state_supul!(id)
  #   {:ok, _state_supul} = StateSupuls.delete_state_supul(state_supul)

  #   conn
  #   |> put_flash(:info, "State supul deleted successfully.")
  #   |> redirect(to: Routes.state_supul_path(conn, :index))
  # end
end
