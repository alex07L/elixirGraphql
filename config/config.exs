# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixirGraphql,
  ecto_repos: [ElixirGraphql.Repo]

# Configures the endpoint
config :elixirGraphql, ElixirGraphqlWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f+GvUhW+8mUlg5DmvfOV8DO9czZocsTsMDLxZ4pmi7HQIhqM6vMkw4Az6ZdrjjcO",
  render_errors: [view: ElixirGraphqlWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ElixirGraphql.PubSub,
  live_view: [signing_salt: "gxPZxriD"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
