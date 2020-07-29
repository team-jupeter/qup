defmodule DemoWeb.TransactionController do
  use DemoWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Demo.Transactions
  alias Demo.Entities.Entity
  alias Demo.InvoiceItems
  alias Demo.Repo
  alias Demo.Events
  alias Demo.Supuls.Supul
  alias Demo.StateSupuls.StateSupul
  alias Demo.NationSupuls.NationSupul

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
    # ? For the buyer
    buyer = current_entity
    buyer_supul = Repo.preload(buyer, :supul).supul
    buyer_state_supul = Repo.preload(buyer_supul, :state_supul).state_supul
    buyer_nation_supul = Repo.preload(buyer_state_supul, :nation_supul).nation_supul
    
    # ? For the seller
    invoice = Repo.preload(current_entity, :invoice).invoice
    invoice_items = InvoiceItems.list_invoice_items(buyer.id)

    seller_id = Enum.at(invoice_items, 0).seller_id

    seller =
      Repo.one(
        from e in Entity,
          where: e.id == ^seller_id
      )

    seller_supul = Repo.preload(seller, :supul).supul  
    seller_state_supul = Repo.preload(seller_supul, :state_supul).state_supul
    seller_nation_supul = Repo.preload(seller_state_supul, :nation_supul).nation_supul
    
    attrs = %{  
      type: "transaction",
      invoice: invoice,   
      buyer_type: buyer.type,       
      buyer_id: buyer.id,
      buyer_name: buyer.name,
      buyer_supul_id: buyer_supul.id,
      buyer_state_supul_id: buyer_state_supul.id,
      buyer_nation_supul_id: buyer_nation_supul.id,
      
      erl_email: buyer.email,
      erl_supul_id: buyer_supul.id,

      seller_type: seller.type,       
      seller_name: seller.name,
      seller_id: seller.id,
      seller_supul_id: seller_supul.id,
      seller_state_supul_id: seller_state_supul.id,
      seller_nation_supul_id: seller_nation_supul.id,

      ssu_email: seller.email,
      ssu_supul_id: seller_supul.id,

    }

    # ? Determine whether the buyer is default_entity, private_entity, or public entity.
    attrs =
      case buyer.type do
        "default" ->
          buyer_family_id = Repo.preload(buyer, :family).family.id

          attrs = 
            Map.merge(attrs, %{
              buyer_family_id: buyer_family_id,
            })

        "private" ->
          buyer_group = Repo.preload(buyer, :group).group
          buyer_group_id = buyer_group.id

          attrs =
            Map.merge(attrs, %{
              buyer_group_id: buyer_group_id,
            })

        "public" -> attrs 
      end

    # ? For the seller
    attrs =
    case seller.type do
      "default" ->
        seller_family_id = Repo.preload(seller, :family).family.id


        attrs = 
          Map.merge(attrs, %{
            seller_family_id: seller_family_id,
          })

      "private" ->
        seller_group = Repo.preload(seller, :group).group
        seller_group_id = seller_group.id

        attrs =
          Map.merge(attrs, %{
            seller_group_id: seller_group_id,
          })

      "public" -> attrs
    end
    # ? Determine whether the seller is default_entity, private_entity, or public entity.
    

    # ? different approach: compare two lines below. 
    # invoices = Invoices.list_seller_invoices(buyer.id)

    {:ok, transaction} = Transactions.create_transaction(attrs)
    IO.inspect("transaction")
    IO.inspect(transaction)

    buyer_private_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    seller_private_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    case Events.create_event(transaction, buyer_private_key, seller_private_key) do
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
