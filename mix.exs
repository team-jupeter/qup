defmodule Demo.Mixfile do
  use Mix.Project

  def project do
    [
      app: :demo,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Demo.Application, []},
      extra_applications: [:logger, :runtime_tools, :inets]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:telemetry_metrics, ">= 0.0.0"},
      {:telemetry_poller, ">= 0.0.0"},
      # Let the dashboard bring phoenix_live_view
      # {:phoenix_live_view, ">= 0.0.0"},
      {:phoenix_live_dashboard, github: "phoenixframework/phoenix_live_dashboard"},
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.8"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:ecto_sql, "~> 3.3"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.13"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:nimble_strftime, ">= 0.0.0"},
      {:pbkdf2_elixir, "~> 1.0"},
      {:phoenix_pubsub_redis, "~> 2.1.0"},
      {:gen_stage, "~> 1.0.0"},
      # {:geo, "~> 3.0"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
