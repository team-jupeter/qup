defmodule DemoWeb.TransactionController do
  use DemoWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Demo.Transactions
  alias Demo.Business.Entity
  alias Demo.InvoiceItems
  # alias Demo.Invoices 
  alias Demo.Repo
  alias Demo.Supuls

  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)  
  end 

  def index(conn, _params, current_entity) do
    transactions = Transactions.list_transactions(current_entity)
    render(conn, "index.html", transactions: transactions)
  end

  def new(conn, _params, current_entity) do
    buyer = current_entity #? buyer ID

    buyer_supul_id = case buyer.supul_id do
    nil -> buyer.nation_supul_id
    _ -> buyer.supul_id
   end

   #? different approach: compare two lines below. 
    # invoices = Invoices.list_buyer_invoices(buyer.id)
    invoice = Repo.preload(current_entity, :invoice).invoice
    invoice_items = InvoiceItems.list_invoice_items(buyer.id)

    seller_id = Enum.at(invoice_items, 0).seller_id
    seller = Repo.one(
      from e in Entity,
        where: e.id == ^seller_id
    )

    seller_supul_id = case seller.supul_id do
      nil -> seller.nation_supul_id
      _ -> seller.supul_id
     end
  
  

    transaction_params = %{
      entity: current_entity,
      invoice: invoice,

      buyer_name: buyer.name, 
      buyer_id: buyer.id,
      buyer_supul_id: buyer_supul_id,
      buyer_supul_name: buyer.supul_name,
 
      seller_name: seller.name, 
      seller_id: seller.id,
      seller_supul_id: seller_supul_id,
      seller_supul_name: seller.supul_name,

      abc_input_id: buyer.id,
      abc_input_name: buyer.name,
      abc_output_id: seller.id,
      abc_output_name: seller.name, 
    }

    case Transactions.create_transaction(transaction_params) do
      {:ok, transaction} ->

        IO.inspect "Transactions.create_transaction"

        conn
        |> put_flash(:info, "Transaction created successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
    
  end

  # def create(conn, invoice, current_entity, buyer_rsa_priv_key, sender_rsa_priv_key) do
  #   conn
  # end

  def show(conn, %{"id" => id}, _current_entity) do
    transaction = Transactions.get_entity_transaction!(id) 
    render(conn, "show.html", transaction: transaction)
  end


  #? payload path for "send to supul" is not working, why? temporalily use edit path.
  def edit(conn,  %{"id" => id}, _current_entity) do
    transaction = Transactions.get_transaction!(id)

    #? hard coding private keys. Those will be extracted from smartphones of trading clients.
    hong_entity_rsa_priv_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    tomi_rsa_priv_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    IO.puts "hi, I am here"
    case Transactions.payload(transaction, hong_entity_rsa_priv_key, tomi_rsa_priv_key) do
      {:ok, payload} ->
        Supuls.check_archive_payload(transaction,payload) #? if pass the check, return transaction
        # |> Supuls.process_transaction() #? executed only if the code above succeeds.
        
      conn
        |> put_flash(:info, "Payload genearted successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transaction: transaction, changeset: changeset)
    end
  end 

  # def delete(conn, %{"id" => id}, current_entity) do
  #   transaction = Transactions.get_transaction!(current_entity, id)
  #   {:ok, _transaction} = Transactions.delete_transaction(transaction)

  #   conn
  #   |> put_flash(:info, "Transaction deleted successfully.")
  #   |> redirect(to: Routes.transaction_path(conn, :index))
  # end
end
