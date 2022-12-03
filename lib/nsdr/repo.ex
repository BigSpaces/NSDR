defmodule Nsdr.Repo do
  use Ecto.Repo,
    otp_app: :nsdr,
    adapter: Ecto.Adapters.Postgres
end
