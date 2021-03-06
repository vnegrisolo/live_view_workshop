defmodule LiveViewWorkshop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LiveViewWorkshop.Tracker,
      # Start the Telemetry supervisor
      LiveViewWorkshopWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveViewWorkshop.PubSub},
      # Start the Endpoint (http/https)
      LiveViewWorkshopWeb.Endpoint
      # Start a worker by calling: LiveViewWorkshop.Worker.start_link(arg)
      # {LiveViewWorkshop.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewWorkshop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveViewWorkshopWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
