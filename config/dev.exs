use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :emporium, Emporium.Endpoint,
 force_ssl: [rewrite_on: [:x_forwarded_proto]],
  http: [port: 80, ip: {10, 10, 10, 77}],
  #http: [port: 4000],
  https: [port: 443,
  otp_app: :emporium,
  keyfile: Map.fetch!(System.get_env(), "SSL_KEY"),
  cacertfile: Map.fetch!(System.get_env(), "SSL_CA_CERT"),
  certfile: Map.fetch!(System.get_env(), "SSL_CERT")],
  url: [host: Map.fetch!(System.get_env(), "PHOENIX_HOSTNAME"), port: 443],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :emporium, Emporium.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20


config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: Map.fetch!(System.get_env(), "GOOGLE_CLIENT_ID"),
  client_secret: Map.fetch!(System.get_env(), "GOOGLE_SECRET")

# Configure your database
config :emporium, Emporium.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: Map.fetch!(System.get_env(), "PG_USERNAME"),
  password: Map.fetch!(System.get_env(), "PG_PASSWORD"),
  database: Map.fetch!(System.get_env(), "PG_DATABASE"),
  hostname: Map.fetch!(System.get_env(), "PG_HOSTNAME"),
  pool_size: Map.fetch!(System.get_env(), "PG_POOLSIZE")
