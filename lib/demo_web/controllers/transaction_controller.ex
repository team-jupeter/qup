defmodule DemoWeb.TransactionController do
  use DemoWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Demo.Transactions
  alias Demo.Entities.Entity
  alias Demo.InvoiceItems
  alias Demo.Repo
  alias Demo.Events
  # alias Demo.Supuls.CheckArchiveEvent

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
    # ? buyer ID
    buyer = current_entity
    transaction_params = %{}

    buyer_supul = Repo.one(from s in Supul, where: s.id == ^buyer.supul_id, select: s)
    buyer_state_supul = Repo.preload(buyer_supul, :state_supul).state_supul
    buyer_state_supul_id = buyer_state_supul.id
    buyer_state_supul_name = buyer_state_supul.name

    buyer_state_supul = Repo.one(from s in StateSupul, where: s.id == ^buyer.supul_id, select: s)
    buyer_nation_supul = Repo.preload(buyer_state_supul, :nation_supul).nation_supul
    buyer_nation_supul_id = buyer_nation_supul.id
    buyer_nation_supul_name = buyer_nation_supul.name

        # ? different approach: compare two lines below. 
    # invoices = Invoices.list_buyer_invoices(buyer.id)
    invoice = Repo.preload(current_entity, :invoice).invoice
    invoice_items = InvoiceItems.list_invoice_items(buyer.id)

    seller_id = Enum.at(invoice_items, 0).seller_id

    seller =
      Repo.one(
        from e in Entity,
          where: e.id == ^seller_id
      )

    seller_supul_id =
      case seller.supul_id do
        nil -> seller.nation_supul_id
        _ -> seller.supul_id
      end

    seller_supul = Repo.one(from s in Supul, where: s.id == ^seller.supul_id, select: s)
    seller_state_supul = Repo.preload(seller_supul, :state_supul).state_supul
    seller_state_supul_id = seller_state_supul.id
    seller_state_supul_name = seller_state_supul.name

    seller_state_supul = Repo.one(from s in StateSupul, where: s.id == ^seller.supul_id, select: s)
    seller_nation_supul = Repo.preload(seller_state_supul, :nation_supul).nation_supul
    seller_nation_supul_id = seller_nation_supul.id
    seller_nation_supul_name = seller_nation_supul.name

    case buyer.default_entity do
      true ->
        buyer_family_id = Repo.preload(buyer, :family).family.id
        transaction_params = %{buyer_family_id: buyer_family_id}

      false ->
        buyer_supul_id =
          case buyer.supul_id do
            # ? public company
            nil -> buyer.nation_supul_id
            _ -> buyer.supul_id
          end
    end


    transaction_params = %{
      entity: current_entity,
      invoice: invoice,
      buyer_name: buyer.name,
      buyer_id: buyer.id,
      buyer_supul_id: buyer.supul_id, 
      buyer_supul_name: buyer.supul_name,
      buyer_state_supul_id: buyer_state_supul_id, 
      buyer_state_supul_name: buyer_state_supul_name,
      buyer_nation_supul_id: buyer_nation_supul_id, 
      buyer_nation_supul_name: buyer_nation_supul_name,

      seller_name: seller.name,
      seller_id: seller.id,
      seller_supul_id: seller.supul_id,
      seller_supul_name: seller.supul_name,
      seller_state_supul_id: seller_state_supul_id, 
      seller_state_supul_name: seller_state_supul_name,
      seller_nation_supul_id: seller_nation_supul_id, 
      seller_nation_supul_name: seller_nation_supul_name,

      abc_input_id: buyer.id,
      abc_input_name: buyer.name,
      abc_output_id: seller.id,
      abc_output_name: seller.name
    }

    buyer_private_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    seller_private_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    case Events.create_event(transaction_params, buyer_private_key, seller_private_key) do
      {:ok, transaction} ->
        # ? Empty cart
        Enum.map(invoice_items, fn item -> InvoiceItems.delete_invoice_item(item) end)

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

  # ? payload path for "send to supul" is not working, why? temporalily use edit path.
  def edit(_conn, %{"id" => id}, _current_entity) do
    transaction = Transactions.get_transaction!(id)

    # ? hard coding private keys. Those will be extracted from smartphones of trading clients.
    hong_entity_rsa_priv_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    tomi_rsa_priv_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    IO.puts("hi, I am here in transaction controller")
    # buyer_supul = Supuls.get_supul!(transaction.buyer_supul_id)
    # seller_supul = Supuls.get_supul!(transaction.seller_supul_id)

    Events.create_event(transaction, hong_entity_rsa_priv_key, tomi_rsa_priv_key)

    # case Events.make_payload(transaction, hong_entity_rsa_priv_key, tomi_rsa_priv_key) do
    #   {:ok, payload} ->
    #     IO.puts "Events.make_payload"

    #     #? Store transaction data into the related supuls. 
    #     CheckArchiveEvent.check_archive_event(transaction, payload) #? if pass the check, return transaction

    #     conn
    #       |> put_flash(:info, "Transaction data was sent to your supul.")
    #       |> redirect(to: Routes.item_path(conn, :index))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "edit.html", transaction: transaction, changeset: changeset)
    # end

    # Transactions.update_transaction(transaction, %{archived?: true})
    # |> Repo.update!
  end

  # def delete(conn, %{"id" => id}, current_entity) do
  #   transaction = Transactions.get_transaction!(current_entity, id)
  #   {:ok, _transaction} = Transactions.delete_transaction(transaction)

  #   conn
  #   |> put_flash(:info, "Transaction deleted successfully.")
  #   |> redirect(to: Routes.transaction_path(conn, :index))
  # end
end
