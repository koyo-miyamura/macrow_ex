defmodule MacrowEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :macrow_ex,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description:
        "MacrowEx provides DSL for defining rules of text replacing. It's inspired by https://github.com/syguer/macrow Ruby gem.",
      package: [
        maintainers: ["koyo"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/koyo-miyamura/macrow_ex"}
      ],
      source_url: "https://github.com/koyo-miyamura/macrow_ex",
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
