defmodule Demo.Tickets do
  @moduledoc """
  The tickets context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Tickets.Ticket
  alias Demo.Trades.Trade

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(ticket_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{ticket_id}")
  end

  @doc """
  Returns the list of tickets.

  ## Examples

      iex> list_tickets()
      [%Ticket{}, ...]

  """
  def list_tickets, do: Repo.all(Ticket)

  def list_tickets(current_page, per_page) do
    Repo.all(
      from u in Ticket,
        order_by: [asc: u.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end

  @doc """
  Gets a single ticket.

  Raises `Ecto.NoResultsError` if the ticket does not exist.

  ## Examples

      iex> get_ticket!(123)
      %Ticket{}

      iex> get_ticket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ticket(id), do: Repo.get(Ticket, id)

  def get_ticket!(id), do: Repo.get!(Ticket, id)

  def get_ticket_by(params), do: Repo.get_by(Ticket, params)

  def authenticate_by_email_and_pass(email, given_pass) do
    ticket = get_ticket_by(email: email)

    cond do
      ticket && Pbkdf2.verify_pass(given_pass, ticket.password_hash) ->
        {:ok, ticket}

      ticket ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end

  @doc """
  Creates a ticket.

  ## Examples

      iex> create_ticket(%{field: value})
      {:ok, %Ticket{}}

      iex> create_ticket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    # |> ticket.changeset(attrs)
    # |> IO.inspect
    |> Ticket.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:ticket, :created])
  end

  @doc """
  Updates a ticket.

  ## Examples

      iex> update_ticket(ticket, %{field: new_value})
      {:ok, %Ticket{}}

      iex> update_ticket(ticket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:ticket, :updated])
  end

  def delete_ticket(%Ticket{} = ticket) do
    # IO.puts "delete_ticket"
    # IO.inspect ticket
    ticket
    |> Repo.delete()
    |> notify_subscribers([:ticket, :deleted])
  end

  def change_ticket(ticket, attrs \\ %{}) do
    ticket.changeset(ticket, attrs)
  end

  def change_registration(%Ticket{} = ticket, params) do
    ticket.changeset(ticket, params)
  end

  def register_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  def upsert_ticket_trades(ticket, trade_ids) when is_list(trade_ids) do
    trades =
      Trade
      |> where([trade], trade.id in ^trade_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           ticket
           |> ticket.changeset_update_trades(trades)
           |> Repo.update() do
      {:ok, get_ticket(ticket.id)}
    else
      error ->
        error
    end
  end

  defp notify_subscribers({:ok, result}, event) do
    # IO.puts "notify_subscribers"
    # IO.inspect result
    # IO.inspect event
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic, {__MODULE__, event, result})
    Phoenix.PubSub.broadcast(Demo.PubSub, @topic <> "#{result.id}", {__MODULE__, event, result})
    {:ok, result}
  end

  defp notify_subscribers({:error, reason}, _event), do: {:error, reason}
end
