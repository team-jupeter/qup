# alias Experimental.GenStage

defmodule B do
  use GenStage

  def init(number) do
    {:producer_consumer, number}
  end

  def handle_events(events, _from, number) do
    events = Enum.map(events, & &1 * number)
    {:noreply, events, number}
  end
end
