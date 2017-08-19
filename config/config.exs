# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :emporium,
  ecto_repos: [Emporium.Repo]

# Configures the endpoint
config :emporium, Emporium.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PnpfwmFgOqgQUrYxFiLaJJq/+kQ2TrImziAKmUv1YqGbS1PRuxj8BucJTpeujCnI",
  render_errors: [view: Emporium.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Emporium.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"]
    ]},
    google: {Ueberauth.Strategy.Google, []}
  ]

  config :guardian, Guardian,
    issuer: "Emporium.#{Mix.env}",
    ttl: {30, :days},
    verify_issuer: true,
    serializer: Emporium.GuardianSerializer,
    secret_key: to_string(Mix.env),
    hooks: GuardianDb,
    permissions: %{
      default: [
        :read_profile,
        :write_profile,
        :read_token,
        :revoke_token,
      ],
    }

  config :guardian_db, GuardianDb,
         repo: Emporium.Repo
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
