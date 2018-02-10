defmodule TicTacToe.Application do
  use Application

  def start(_type, args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(TicTacToe.Server, args)
    ]

    options = [
      name: TicTacToe.Supervisor,
      strategy: :simple_one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end
