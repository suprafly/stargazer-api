# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stargazer_api,
  ecto_repos: [StargazerApi.Repo]

# Configures the endpoint
config :stargazer_api, StargazerApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9gtbt6ArkBmVUnZJsipOOlxHPBHUn/A5Wo/XbOLExer3n1VQBvQdz0ZyUAIBUlSC",
  render_errors: [view: StargazerApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: StargazerApi.PubSub,
  live_view: [signing_salt: "bRMffgxD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
