defmodule Emporium.Mixfile do
  use Mix.Project

  def project do
    [app: :emporium,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Emporium, []},
     applications: [
    #  :couchdb_adapter,
      :phoenix,
      :phoenix_pubsub,
      :phoenix_html,
      :cowboy,
      :logger,
      :gettext,
      :amnesia,
      :phoenix_ecto,
      :postgrex,
      :oauth2,
      :ueberauth,
      :ueberauth_identity,
      :ueberauth_google,
      :comeonin,
      :gproc]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    # path_to_workdir = "/home/sergey/workspace/elixir/couchdb_elixir/"
    [
     # {:couchdb_adapter, path: path_to_workdir <> "couchdb_adapter"},
     {:poison, "~> 3.0", override: true},
     {:phoenix, "~> 1.2.4"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:gettext, "~> 0.13"},
     {:cowboy, "~> 1.0"},
     {:comeonin, "~> 3.0"},
     {:guardian_db, "~> 0.8.0"},
     {:guardian, "~> 0.14"},
     {:ueberauth, "~> 0.4"},
     {:ueberauth_identity, "~> 0.2"},
     {:ueberauth_google, "~> 0.5"},
     {:amnesia, github: "meh/amnesia", tag: :master},
     {:gproc, "~> 0.6.1"}
      ]
  end



  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
