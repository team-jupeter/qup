defmodule Demo.Airports do
  @moduledoc """
  The Passengers context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Airports.Passenger
  alias Demo.Trades.Trade

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic)
  end

  def subscribe(passenger_id) do
    Phoenix.PubSub.subscribe(Demo.PubSub, @topic <> "#{passenger_id}")
  end

  @doc """
  Returns the list of passengers.

  ## Examples

      iex> list_passengers()
      [%passenger{}, ...]

  """
  def list_passengers, do: Repo.all(Passenger)

  def list_passengers(current_page, per_page) do
    Repo.all(
      from u in Passenger,
        order_by: [asc: u.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end

  @doc """
  Gets a single passenger.

  Raises `Ecto.NoResultsError` if the passenger does not exist.

  ## Examples

      iex> get_passenger!(123)
      %passenger{}

      iex> get_passenger!(456)
      ** (Ecto.NoResultsError)

  """
  def get_passenger(id), do: Repo.get(Passenger, id)

  def get_passenger!(id), do: Repo.get!(Passenger, id)

  def get_passenger_by(params), do: Repo.get_by(Passenger, params)

  def authenticate_by_email_and_pass(email, given_pass) do
    passenger = get_passenger_by(email: email)

    cond do
      passenger && Pbkdf2.verify_pass(given_pass, passenger.password_hash) ->
        {:ok, passenger}

      passenger ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end

  @doc """
  Creates a passenger.

  ## Examples

      iex> create_passenger(%{field: value})
      {:ok, %passenger{}}

      iex> create_passenger(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_passenger(attrs \\ %{}) do
    %Passenger{}
    # |> passenger.changeset(attrs)
    # |> IO.inspect
    |> Passenger.changeset(attrs)
    |> Repo.insert()
    |> notify_subscribers([:passenger, :created])
  end

  @doc """
  Updates a passenger.

  ## Examples

      iex> update_passenger(passenger, %{field: new_value})
      {:ok, %passenger{}}

      iex> update_passenger(passenger, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_passenger(%Passenger{} = passenger, attrs) do
    passenger
    |> Passenger.changeset(attrs)
    |> Repo.update()
    |> notify_subscribers([:passenger, :updated])
  end

  def delete_passenger(%Passenger{} = passenger) do
    # IO.puts "delete_passenger"
    # IO.inspect passenger
    passenger
    |> Repo.delete()
    |> notify_subscribers([:passenger, :deleted])
  end

  def change_passenger(passenger, attrs \\ %{}) do
    passenger.changeset(passenger, attrs)
  end

  def change_registration(%Passenger{} = passenger, params) do
    Passenger.changeset(passenger, params)
  end

  def register_passenger(attrs \\ %{}) do
    %Passenger{}
    |> Passenger.changeset(attrs)
    |> Repo.insert()
  end

  def upsert_passenger_trades(passenger, trade_ids) when is_list(trade_ids) do
    trades =
      Trade
      |> where([trade], trade.id in ^trade_ids)
      |> Repo.all()

    with {:ok, _struct} <-
           passenger
           |> passenger.changeset_update_trades(trades)
           |> Repo.update() do
      {:ok, get_passenger(passenger.id)}
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
