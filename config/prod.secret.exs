use Mix.Config

config :compounds, Compounds.Repo,
  # ssl: true,
  adapter: Ecto.Adapters.Postgres,
  port: System.get_env("DB_PORT") || 5432,
  username: System.get_env("DB_USER") || "postgres",
  password: System.get_env("DB_PASS") || "postgres",
  database:  System.get_env("DB_NAME") || "compounds_prod",
  hostname:  System.get_env("DB_HOST") || "localhost",
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :compounds, CompoundsWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: System.get_env("SECRET_KEY_BASE") || "EzQhp/hKtBanJLRI9hh2MG3RfjTUcaTGFgSYrHYatqUhAUUDbdr8e9hsZbD9f1HG"
