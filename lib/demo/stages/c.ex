# alias Experimental.GenStage

defmodule C do
  use GenStage

  def init(sleeping_time) do
    {:consumer, sleeping_time}
  end

  def handle_events(events, _from, sleeping_time) do
    # Print events to terminal.
    IO.inspect(events)

    # Sleep the configured time.
    Process.sleep(sleeping_time)

    # We are a consumer, so we never emit events.
    {:noreply, [], sleeping_time}
  end
end
