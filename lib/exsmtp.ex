defmodule Exsmtp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Exsmtp.Server, [], restart: :transient)
    ]

    opts = [strategy: :one_for_one, name: Exsmtp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
