# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :world_cup_db,
  ecto_repos: [WorldCupDb.Repo]

# Configures the endpoint
config :world_cup_db, WorldCupDb.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bDKpEnncY5D582lXnYQkj7TYu5VNHr3H/mA9CCH2zNqDM/zaUGq6+Xl9NnsDgghL",
  render_errors: [view: WorldCupDb.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WorldCupDb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders, json: WorldCupDb.PrettyPoisonEncoderForPhoenix

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
