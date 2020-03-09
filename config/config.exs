# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bread,
  ecto_repos: [Bread.Repo]

# Configures the endpoint
config :bread, BreadWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BLBvvQTPKEpu/zCOzEMOjP1IcUXbC7KSzTlgpC5ZW80/D39Th5n96UG/REX/wgc1",
  render_errors: [view: BreadWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bread.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "5EMj+TTk0RIPRh+T3NCqOa2eousCW++2"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :bread, :pow,
  user: Bread.Users.User,
  repo: Bread.Repo,
  web_module: BreadWeb

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
