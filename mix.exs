defmodule Imagedownloader.Mixfile do
  use Mix.Project

  def project do
    [app: :imagedownloader,
     version: "0.1.0",
     elixir: "~> 1.3",
     escript: [main_module: ImageDownloader],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:httpotion]]
    # Note Added HttpPotion here as it needs to auto-start
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
     [
      {:httpotion, "~> 3.0.2"},
      {:floki, "~> 0.11.0"},
      {:mogrify, "~> 0.5.2"}
    ]
  end
end
