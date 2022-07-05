defmodule BencheeEts.MixProject do
  use Mix.Project

  def project do
    [
      app: :benchee_ets,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # benchee itself
      {:benchee, "~> 1.0"},
      # to generate nice visual reports
      {:benchee_html, "~> 1.0"},
      # to fake ETS data
      {:faker, "~> 0.17"}
    ]
  end
end
