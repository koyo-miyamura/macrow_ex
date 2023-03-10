defmodule MacrowEx.MixProject do
  use Mix.Project

  @source_url "https://github.com/koyo-miyamura/macrow_ex"
  @version "0.1.1"

  def project do
    [
      app: :macrow_ex,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description:
        "MacrowEx provides DSL for defining rules of text replacing. It's inspired by https://github.com/syguer/macrow Ruby gem.",
      package: [
        maintainers: ["koyo"],
        licenses: ["MIT"],
        links: %{"GitHub" => @source_url}
      ],
      source_url: @source_url,
      docs: [
        source_ref: @version,
        source_url: @source_url
      ],
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
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
