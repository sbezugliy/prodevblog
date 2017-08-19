use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :emporium, Emporium.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :emporium, Emporium.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: Map.fetch!(System.get_env(), "PG_USERNAME"),
  password: Map.fetch!(System.get_env(), "PG_PASSWORD"),
  database: Map.fetch!(System.get_env(), "PG_DATABASE_TEST"),
  hostname: Map.fetch!(System.get_env(), "PG_HOSTNAME"),
  pool_size: 10
