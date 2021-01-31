defmodule Compounds.Repo do
  use Ecto.Repo,
    otp_app: :compounds,
    adapter: Ecto.Adapters.Postgres
end
