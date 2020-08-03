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
    invoice = Repo.preload(current_entity, :invoice).invoice
    bs = Repo.preload(current_entity, :balance_sheet).balance_sheet

    if bs.cash < invoice.total, do: "error"

    # ? For the erl
    IO.puts "transaction_controller, erl_supul"
    erl = current_entity
    erl_supul = Repo.preload(erl, :supul).supul
    erl_state_supul = Repo.preload(erl_supul, :state_supul).state_supul
    erl_nation_supul = Repo.preload(erl_state_supul, :nation_supul).nation_supul
    
    invoice_items = InvoiceItems.list_invoice_items(erl.id)
    
    # ? For the ssu
    ssu_id = Enum.at(invoice_items, 0).seller_id

    ssu =
      Repo.one(
        from e in Entity,
          where: e.id == ^ssu_id
      )

    ssu_supul = Repo.preload(ssu, :supul).supul
    ssu_state_supul = Repo.preload(ssu_supul, :state_supul).state_supul
    ssu_nation_supul = Repo.preload(ssu_state_supul, :nation_supul).nation_supul

    attrs = %{
      type: "transaction",
      invoice: invoice,

      erl_type: erl.type,
      erl_id: erl.id,
      erl_name: erl.name,
      erl_email: erl.email,
      erl_supul_id: erl_supul.id,
      erl_state_supul_id: erl_state_supul.id,
      erl_nation_supul_id: erl_nation_supul.id,

      ssu_type: ssu.type,
      ssu_id: ssu.id,
      ssu_name: ssu.name,
      ssu_email: ssu.email,
      ssu_supul_id: ssu_supul.id,
      ssu_state_supul_id: ssu_state_supul.id,
      ssu_nation_supul_id: ssu_nation_supul.id,
      abc_amount: invoice.total
    }

    # ? Determine whether the erl is default_entity, private_entity, or public entity.
    attrs =
      case erl.type do
        "default" ->
          erl_family_id = Repo.preload(erl, :family).family.id

          attrs =
            Map.merge(attrs, %{
              erl_family_id: erl_family_id
            })

        "private" ->
          erl_group = Repo.preload(erl, :group).group
          erl_group_id = erl_group.id

          attrs =
            Map.merge(attrs, %{
              erl_group_id: erl_group_id
            })

        "public" ->
          attrs
      end

    # ? For the seller
    attrs =
      case ssu.type do
        "default" ->
          ssu_family_id = Repo.preload(ssu, :family).family.id

          attrs =
            Map.merge(attrs, %{
              ssu_family_id: ssu_family_id
            })

        "private" ->
          ssu_group = Repo.preload(ssu, :group).group
          ssu_group_id = ssu_group.id

          attrs =
            Map.merge(attrs, %{
              ssu_group_id: ssu_group_id
            })

        "public" ->
          attrs
      end

    # ? Determine whether the seller is default_entity, private_entity, or public entity.

    # ? different approach: compare two lines below. 
    # invoices = Invoices.list_seller_invoices(erl.id)

    {:ok, transaction} = Transactions.create_transaction(attrs)

    # ? hard coded keys
    erl_private_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    ssu_private_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    case Events.create_event(transaction, erl_private_key, ssu_private_key) do
      {:ok, _event} ->
        # ? Empty cart
        Enum.map(invoice_items, fn item -> InvoiceItems.delete_invoice_item(item) end)

        conn
        |> put_flash(:info, "Transaction created successfully.")
        |> redirect(to: Routes.transaction_path(conn, :show, transaction))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end



  # def create(conn, invoice, current_entity, erl_rsa_priv_key, sender_rsa_priv_key) do
  #   conn
  # end

  def show(conn, %{"id" => id}, current_entity) do
    transaction = Transactions.get_transaction!(id)
    render(conn, "show.html", transaction: transaction)
  end

  # ? payload path for "send to supul" is not working, why? temporalily use edit path.
  def edit(_conn, %{"id" => id}, _current_entity) do
    transaction = Transactions.get_transaction!(id)

    # ? hard coding private keys. Those will be extracted from smartphones of trading clients.
    hong_entity_rsa_priv_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    tomi_rsa_priv_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    IO.puts("hi, I am here in transaction controller")
    # erl_supul = Supuls.get_supul!(transaction.erl_supul_id)
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
