# context
defmodule Demo.Aviation do
  @pubsub_name :aviation # pubsub process pid
  @pubsub_topic "traffic"

  def arrive(airport, airline, number_of_passengers) when is_binary(airline) and is_integer(number_of_passengers) do
    Phoenix.PubSub.broadcast(@pubsub_name, @pubsub_topic, {:arrival, %{airport: airport, airline: airline, number_of_passengers: number_of_passengers}})
  end

  def depart(airport, airline, number_of_passengers) when is_binary(airline) and is_integer(number_of_passengers) do
    Phoenix.PubSub.broadcast(@pubsub_name, @pubsub_topic, {:departure, %{airport: airport, airline: airline, number_of_passengers: number_of_passengers}})
  end
end


