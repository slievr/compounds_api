# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :compounds,
  ecto_repos: [Compounds.Repo]

# Configures the endpoint
config :compounds, CompoundsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EzQhp/hKtBanJLRI9hh2MG3RfjTUcaTGFgSYrHYatqUhAUUDbdr8e9hsZbD9f1HG",
  render_errors: [view: CompoundsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Compounds.PubSub,
  live_view: [signing_salt: "vfuocEFY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
