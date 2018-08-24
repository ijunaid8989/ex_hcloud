defmodule HetznerCloud.MixProject do
  use Mix.Project

  def project do
    [
      app: :hcloud,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :httpoison, :poison]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.2"},
      {:poison, "~> 4.0"}
    ]
  end
end