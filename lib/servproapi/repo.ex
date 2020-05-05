defmodule Servproapi.Repo do
  use Ecto.Repo,
    otp_app: :servproapi,
    adapter: Ecto.Adapters.Postgres
end
