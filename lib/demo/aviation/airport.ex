# PubSub 1
defmodule Demo.Airport do
  use GenServer
  # Interface or Client
  # @pubsub_name :aviation # pubsub process pid
  # @pubsub_topic "traffic"

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  # def inform_airport(user, socket.assigns.airport, params) do

  # end
  def init(_) do
    # IO.inspect @pubsub_name # :aviation
    Phoenix.PubSub.subscribe(:aviation, "traffic")
    {:ok, %{}}
  end

  # Server or Implementation
  def handle_call(:get, _, state) do
    {:reply, state, state}
  end

  def handle_info({:arrival, %{airport: airport, airline: airline, number_of_passengers: number_of_passengers}}, state) do
    IO.puts("Scheduled (#{number_of_passengers}) passengers to arrive via #{airline} at #{airport}")

    updated_state = state
      |> Map.update(airline, number_of_passengers, &(&1 + number_of_passengers))

    {:noreply, updated_state}
  end

  def handle_info({:departure, %{airport: airport, airline: airline, number_of_passengers: number_of_passengers}}, state) do
    IO.puts("Scheduled (#{number_of_passengers}) passengers to leave via #{airline} at #{airport}")

    updated_state = state
      |> Map.update(airline, 0, &(&1 - number_of_passengers))
      |> Enum.reject(fn({_, v}) -> v <= 0 end)
      |> Map.new

    {:noreply, updated_state}
  end
end

