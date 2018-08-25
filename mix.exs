defmodule HetznerCloud.MixProject do
  use Mix.Project

  def project do
    [
      app: :hcloud,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description()
    ]
  end

  def description, do: "HetznerCloud client for Elixir"

  def package do
    [
      name: :hcloud,
      maintainers: ["Junaid Farooq"],
      licenses: ["MIT"],
      docs: [extras: ["README.md"]],
      links: %{"GitHub" => "https://github.com/ijunaid8989/ex_hcloud"}
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
      {:poison, "~> 4.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end
end
