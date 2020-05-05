# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :servproapi,
  ecto_repos: [Servproapi.Repo]

# Configures the endpoint
config :servproapi, ServproapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2HW9IOPfI1Yrsdz1VZ3rKDBZ99ekFySNHBmKnZixeSNgOW5zKxVgRbbOnKHcCTDX",
  render_errors: [view: ServproapiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Servproapi.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "WYwG4c6/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
