# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mbanking,
  ecto_repos: [Mbanking.Repo]

# Configures the endpoint
config :mbanking, MbankingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tO14VbtQhy3YaG5Ljktnuw+sN7T1aPO4gScHZ28RjSVecV/Av6+VRkkpyxV5ERVF",
  render_errors: [view: MbankingWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Mbanking.PubSub,
  live_view: [signing_salt: "teQcTgxH"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Set Cipher configs
config :cipher,
  keyphrase: "testiekeyphraseforcipher",
  ivphrase: "testieivphraseforcipher",
  magic_token: "magictoken"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
