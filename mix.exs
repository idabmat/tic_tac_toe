defmodule TicTacToe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tic_tac_toe,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: { TicTacToe.Application, [] },
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end
end
