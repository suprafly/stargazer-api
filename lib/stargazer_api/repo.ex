defmodule StargazerApi.Repo do
  use Ecto.Repo,
    otp_app: :stargazer_api,
    adapter: Ecto.Adapters.Postgres
end
