defmodule DemoWeb.TransactionController do
  use DemoWeb, :controller

  alias Demo.Transactions
  alias Demo.Transactions.Transaction

  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)  
  end 

  def index(conn, _params, current_entity) do
    transactions = Transactions.list_transactions(current_entity)
    render(conn, "index.html", transactions: transactions)
  end

  def new(conn, _params, _current_entity) do
    changeset = Transactions.change_transaction(%Transaction{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transaction" => transaction_params}, current_entity, buyer_rsa_priv_key, sender_rsa_priv_key) do
    case Transactions.create_transaction(current_entity, transaction_params, buyer_rsa_priv_key, sender_rsa_priv_key) do
      {:ok, transaction} ->
        conn
        |> put_flash(:info, "Transaction created successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, _current_entity) do
    IO.inspect id

    transaction = Transactions.get_transaction!(id)

    IO.inspect transaction
    
    render(conn, "show.html", transaction: transaction)
  end

  def edit(conn, %{"id" => id}, current_entity) do
    transaction = Transactions.get_entity_transaction!(current_entity, id)
    changeset = Transactions.change_transaction(transaction)
    render(conn, "edit.html", transaction: transaction, changeset: changeset)
  end

  # def update(conn, %{"id" => id, "transaction" => transaction_params}, current_entity) do
  #   transaction = Transactions.get_transaction!(current_entity, id)

  #   case Transactions.update_transaction(transaction, transaction_params) do
  #     {:ok, transaction} ->
  #       conn
  #       |> put_flash(:info, "Transaction updated successfully.")
  #       |> redirect(to: Routes.transaction_path(conn, :show, transaction))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", transaction: transaction, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}, current_entity) do
  #   transaction = Transactions.get_transaction!(current_entity, id)
  #   {:ok, _transaction} = Transactions.delete_transaction(transaction)

  #   conn
  #   |> put_flash(:info, "Transaction deleted successfully.")
  #   |> redirect(to: Routes.transaction_path(conn, :index))
  # end
end
