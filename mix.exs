defmodule TicTacToe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tic_tac_toe,
      version: "1.1.1",
      description: "A TicTacToe game engine",
      package: package(),
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      source_url: "https://github.com/idabmat/tic_tac_toe",
      homepage_url: "https://github.com/idabmat/tic_tac_toe",
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: { TicTacToe.Application, [] },
      extra_applications: [:logger],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      maintainers: ["idabmat@gmail.com"],
      links: %{"GitHub" => "https://github.com/idabmat/tic_tac_toe"},
    ]
  end
end
