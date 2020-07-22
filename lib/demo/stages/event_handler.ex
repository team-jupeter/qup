defmodule EventHandler do
  use GenStage

  def start_link() do
    GenStage.start_link(__MODULE__, :ok)
  end

  # Callbacks

  def init(:ok) do
    # Starts a permanent subscription to the broadcaster
    # which will automatically start requesting items.
    {:consumer, :ok, subscribe_to: [EventManager]}
  end

  def handle_events(events, _from, state) do
    {:noreply, [], state}
  end
end
