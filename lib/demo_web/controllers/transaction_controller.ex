defmodule DemoWeb.TransactionController do
  use DemoWeb, :controller
  import Ecto.Query, only: [from: 2]
  alias Demo.Transactions
  alias Demo.Entities.Entity
  alias Demo.InvoiceItems
  alias Demo.Repo
  alias Demo.Events
  # alias Demo.Supuls.Supul
  # alias Demo.StateSupuls.StateSupul
  # alias Demo.NationSupuls.NationSupul

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

    if bs.t1_balance < invoice.total, do: "error" 

    # ? For the input
    input = current_entity
    input_supul = Repo.preload(input, :supul).supul
    input_state_supul = Repo.preload(input_supul, :state_supul).state_supul
    input_nation_supul = Repo.preload(input_state_supul, :nation_supul).nation_supul

    invoice_items = InvoiceItems.list_invoice_items(input.id)

    # ? For the output
    output_id = Enum.at(invoice_items, 0).seller_id

    output =
      Repo.one(
        from e in Entity,
          where: e.id == ^output_id
      )

    output_supul = Repo.preload( output, :supul).supul
    output_state_supul = Repo.preload(output_supul, :state_supul).state_supul
    output_nation_supul = Repo.preload(output_state_supul, :nation_supul).nation_supul

    attrs = %{
      type: "transaction",
      invoice: invoice,
      input_type: input.type,
      input_id: input.id,
      input_name: input.name,
      input_email: input.email,
      input_supul_id: input_supul.id,
      input_state_supul_id: input_state_supul.id,
      input_nation_supul_id: input_nation_supul.id,
      output_type: output.type,
      output_id: output.id,
      output_name: output.name,
      output_email: output.email,
      output_supul_id: output_supul.id,
      output_state_supul_id: output_state_supul.id,
      output_nation_supul_id: output_nation_supul.id,
      t1_amount: invoice.total,
    }

    # ? Determine whether the input is default_entity, private_entity, or public entity.
    attrs =
      case input.type do
        "default" ->
          input_family_id = Repo.preload(input, :family).family.id

          Map.merge(attrs, %{
            input_family_id: input_family_id
          })

        "private" ->
          input_group = Repo.preload(input, :group).group
          input_group_id = input_group.id

          Map.merge(attrs, %{
            input_group_id: input_group_id
          })

        "public" ->
          attrs
      end

    # ? For the seller
    attrs =
      case output.type do
        "default" ->
          output_family_id = Repo.preload( output, :family).family.id

          Map.merge(attrs, %{
            output_family_id: output_family_id
          })

        "private" ->
          output_group = Repo.preload( output, :group).group
          output_group_id = output_group.id

          Map.merge(attrs, %{
            output_group_id: output_group_id
          })

        "public" ->
          attrs
      end

    # ? Determine whether the seller is default_entity, private_entity, or public entity.

    # ? different approach: compare two lines below. 
    # invoices = Invoices.list_seller_invoices(input.id)

    {:ok, transaction} = Transactions.create_transaction(attrs)

    # ? hard coded keys
    input_private_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    output_private_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    case Events.create_event(transaction, input_private_key, output_private_key) do
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

  # def create(conn, invoice, current_entity, input_rsa_priv_key, sender_rsa_priv_key) do
  #   conn
  # end

  def show(conn, %{"id" => id}, _current_entity) do
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
    Events.create_event(transaction, hong_entity_rsa_priv_key, tomi_rsa_priv_key)
  end
end
