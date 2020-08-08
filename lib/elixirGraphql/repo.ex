defmodule ElixirGraphql.Repo do
  use Ecto.Repo,
    otp_app: :elixirGraphql,
    adapter: Ecto.Adapters.Postgres
end
