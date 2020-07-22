defmodule Demo.Gopang.Tickets do
  import Ecto.Query, warn: false

  alias Demo.Repo
  alias Demo.Gopang.Ticket
  alias Demo.Entities.Entity
  # alias Demo.Invoices


  def list_tickets do
    Repo.all(Ticket)
  end

  def list_entity_tickets(%Entity{} = entity) do
    Ticket
    |> entity_tickets_query(entity)
    |> Repo.all()
  end

  def get_entity_ticket!(%Entity{} = entity, id) do
    Ticket
    |> entity_tickets_query(entity)
    |> Repo.get!(id)
  end 

  def get_ticket!(id), do: Repo.get!(Ticket, id)

  defp entity_tickets_query(query, %Entity{id: entity_id}) do
    from(p in query, where: p.entity_id == ^entity_id)
  end

  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end 

  def create_ticket(%Entity{} = entity, attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:entity, entity)
    |> Repo.insert()
  end

  def change_ticket(%Ticket{} = ticket) do
    Ticket.changeset(ticket, %{})
  end

end
