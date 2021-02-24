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
