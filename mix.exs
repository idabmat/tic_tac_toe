defmodule TicTacToe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tic_tac_toe,
      version: "2.0.1",
      description: "A TicTacToe game engine",
      package: package(),
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      source_url: "https://github.com/idabmat/tic_tac_toe",
      homepage_url: "https://github.com/idabmat/tic_tac_toe",
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        list_unused_filters: true
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      maintainers: ["idabmat@gmail.com"],
      links: %{"GitHub" => "https://github.com/idabmat/tic_tac_toe"}
    ]
  end

  defp aliases do
    [
      lint: ["credo --strict"],
      typecheck: ["dialyzer"]
    ]
  end
end
