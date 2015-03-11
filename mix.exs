defmodule Exsmtp.Mixfile do
  use Mix.Project

  def project do
    [app: :exsmtp,
      version: "0.0.1",
      elixir: "~> 1.0",
      description: description,
      package: package,
      deps: deps]
  end

  def application do
    [applications: [:logger],
      mod: {Exsmtp, []}]
  end

  def description do
    "Basic SMTP server for Elixir"
  end

  def package do
    [
      contributors: ["Bradley Smith"],
      licenses: ["The MIT License"],
      links: %{
        "GitHub" => "https://github.com/bradleyd/exsmtp"
      }
  ]
  end

  defp deps do
    [
      {:eiconv,    github: "zotonic/eiconv"},
      {:gen_smtp,  github: "Vagabond/gen_smtp"},
      { :uuid, "~> 1.0" }
    ]
  end
end
