defmodule Tos.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Tos.Repo,
      # Start the Telemetry supervisor
      TosWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tos.PubSub},
      # Start the Endpoint (http/https)
      TosWeb.Endpoint
      # Start a worker by calling: Tos.Worker.start_link(arg)
      # {Tos.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tos.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TosWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
