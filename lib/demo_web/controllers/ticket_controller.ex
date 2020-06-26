#---
defmodule DemoWeb.TicketController do
  use DemoWeb, :controller

  alias Demo.Gopang.Tickets
  alias Demo.Gopang.Ticket
 
  plug DemoWeb.EntityAuth when action in [:index, :new, :edit, :create, :show]

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_entity]
    apply(__MODULE__, action_name(conn), args)  
  end

  def index(conn, _params, current_entity) do
    tickets = Tickets.list_entity_tickets(current_entity) 
    IO.puts "Ticket controller index"
    render(conn, "index.html", tickets: tickets)
  end 

  def show(conn, %{"id" => id}, current_entity) do
    ticket = Tickets.get_entity_ticket!(current_entity, id) 
    render(conn, "show.html", ticket: ticket) 
  end
  
  def edit(conn, %{"id" => id}, current_entity) do
    ticket = Tickets.get_entity_ticket!(current_entity, id) 
    changeset = Tickets.change_ticket(ticket)
    render(conn, "edit.html", ticket: ticket, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}, current_entity) do
    ticket = Tickets.get_entity_ticket!(current_entity, id) 

    case Tickets.update_ticket(ticket, ticket_params) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket updated successfully.")
        |> redirect(to: Routes.ticket_path(conn, :show, ticket))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", ticket: ticket, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_entity) do
    ticket = Tickets.get_entity_ticket!(current_entity, id) 
    {:ok, _ticket} = Tickets.delete_ticket(ticket)

    conn
    |> put_flash(:info, "Ticket deleted successfully.")
    |> redirect(to: Routes.ticket_path(conn, :index))
  end

  def new(conn, _params, _current_entity) do
    changeset = Tickets.change_ticket(%Ticket{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ticket" => ticket_params}, current_entity) do
    case Tickets.create_ticket(current_entity, ticket_params) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket created successfully.")
        |> redirect(to: Routes.ticket_path(conn, :show, ticket))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
