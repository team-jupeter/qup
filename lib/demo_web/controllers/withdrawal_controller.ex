defmodule DemoWeb.WithdrawalController do
  use DemoWeb, :controller

  alias Demo.Withdrawals
  alias Demo.Withdrawals.Withdrawal

  def index(conn, _params) do
    withdrawals = Withdrawals.list_withdrawals()
    render(conn, "index.html", withdrawals: withdrawals)
  end

  def new(conn, _params) do
    changeset = Withdrawals.change_withdrawal(%Withdrawal{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"withdrawal" => withdrawal_params}) do
    case Withdrawals.create_withdrawal(withdrawal_params) do
      {:ok, withdrawal} ->
        conn
        |> put_flash(:info, "Withdrawal created successfully.")
        |> redirect(to: Routes.withdrawal_path(conn, :show, withdrawal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    withdrawal = Withdrawals.get_withdrawal!(id)
    render(conn, "show.html", withdrawal: withdrawal)
  end

  def edit(conn, %{"id" => id}) do
    withdrawal = Withdrawals.get_withdrawal!(id)
    changeset = Withdrawals.change_withdrawal(withdrawal)
    render(conn, "edit.html", withdrawal: withdrawal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "withdrawal" => withdrawal_params}) do
    withdrawal = Withdrawals.get_withdrawal!(id)

    case Withdrawals.update_withdrawal(withdrawal, withdrawal_params) do
      {:ok, withdrawal} ->
        conn
        |> put_flash(:info, "Withdrawal updated successfully.")
        |> redirect(to: Routes.withdrawal_path(conn, :show, withdrawal))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", withdrawal: withdrawal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    withdrawal = Withdrawals.get_withdrawal!(id)
    {:ok, _withdrawal} = Withdrawals.delete_withdrawal(withdrawal)

    conn
    |> put_flash(:info, "Withdrawal deleted successfully.")
    |> redirect(to: Routes.withdrawal_path(conn, :index))
  end
end
