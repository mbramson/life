# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :life,
  ecto_repos: [Life.Repo]

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Configures the endpoint
config :life, LifeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NfGIRvFpdymmZOA5vZ4uuMHymMaSso/UnwrNAlGYRYu3Ma7aY8zzM1rlp5WxF+ZG",
  render_errors: [view: LifeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Life.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "3xMRARn8wJEkVNwvV/2opJ6Y1Vc5aEFK"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
