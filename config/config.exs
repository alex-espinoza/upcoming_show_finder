# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :upcoming_show_finder,
  ecto_repos: [UpcomingShowFinder.Repo]

# Configures the endpoint
config :upcoming_show_finder, UpcomingShowFinder.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dUdrXH2bdlS6+gP3rrZ4Dk9jsLvQ9uHBd59O566oUU/NN1K+qZBW6mV+FYRrt+Th",
  render_errors: [view: UpcomingShowFinder.ErrorView, accepts: ~w(html json)],
  pubsub: [name: UpcomingShowFinder.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
