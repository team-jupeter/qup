defmodule Demo.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Demo.Repo,
      DemoWeb.Telemetry,
      DemoWeb.Endpoint,
      DemoWeb.Presence,

      # start: {Phoenix.PubSub.PG2, :start_link, [:aviation, []]}
      %{
        id: Phoenix.PubSub.Redis,

        start: {Phoenix.PubSub.Redis, :start_link, [:aviation, [
          pool_size: 1,
          node_name: "name"
        ]]}
      },

      # {Demo.Stages.Producer, 0},
      # {Demo.Stages.ProducerConsumer, []},
      # {Demo.Stages.Consumer, []}
    ]

    opts = [strategy: :one_for_one, name: Demo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    DemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
