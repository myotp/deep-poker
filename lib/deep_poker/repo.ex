defmodule DeepPoker.Repo do
  use Ecto.Repo,
    otp_app: :deep_poker,
    adapter: Ecto.Adapters.Postgres
end
