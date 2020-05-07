# alias Experimental.GenStage

defmodule A do
  use GenStage

  def init(counter) do
    {:producer, counter}
  end

  def handle_demand(demand, counter) when demand > 0 do
    IO.inspect demand
    # If the counter is 3 and we ask for 2 items, we will
    # emit the items 3 and 4, and set the state to 5.
    events = Enum.to_list(counter..counter+demand-1)

    # The events to emit is the second element of the tuple,
    # the third being the state.
    {:noreply, events, counter + demand}
  end
end
