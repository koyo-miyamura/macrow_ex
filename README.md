# MacrowEx

`MacrowEx` provides DSL for defining rules of text replacing.

It's inspired by https://github.com/syguer/macrow Ruby gem.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `macrow_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:macrow_ex, "~> 0.1.0"}
  ]
end
```

## How to use

Define your module and write `use MacrowEx`.

MacrowEx provides `rules/2` DSL to define replacement rules.

The second argument is function to replace and must return string.

```elixir
defmodule MyMacrowEx do
  use MacrowEx

  rules "hoge", fn ->
    "ほげ"
  end

  rules "len", fn array ->
    length(array) |> Integer.to_string()
  end
end
```

Then `apply/1` `apply/2` function generates in your module.

```elixir
MyMacrowEx.apply("${hoge}")
  "ほげ"

MyMacrowEx.apply("${hoge} length is ${len}", [1,2,3])
  "ほげ length is 3"
```

## Format

When you do not want to format DSL provided by MacrowEx, try to write in your `.formatter.exs` as follows.

```elixir
[
  import_deps: [:macrow_ex]
]
```
