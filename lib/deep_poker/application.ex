defmodule DeepPoker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DeepPokerWeb.Telemetry,
      DeepPoker.Repo,
      {DNSCluster, query: Application.get_env(:deep_poker, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DeepPoker.PubSub},
      # Start a worker by calling: DeepPoker.Worker.start_link(arg)
      # {DeepPoker.Worker, arg},
      # Start to serve requests, typically the last entry
      DeepPokerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DeepPoker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DeepPokerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
