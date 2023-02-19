defmodule MacrowEx do
  @moduledoc """
  Documentation for `MacrowEx`.
  """

  @doc """
  apply macro.

  ## Examples

      iex> MacrowEx.apply("${hoge}", [%{src: "hoge", replacer: fn _context -> "ほげ" end}])
      "ほげ"

      iex> MacrowEx.apply("hoge${hoge}hoge", [%{src: "hoge", replacer: fn _context -> "ほげ" end}])
      "hogeほげhoge"

      iex> MacrowEx.apply("hoge${hoge}hoge${hoge}", [%{src: "hoge", replacer: fn _context -> "ほげ" end}])
      "hogeほげhogeほげ"

      iex> MacrowEx.apply("${hoge}", [])
      "${hoge}"

  """
  def apply(str, rules) when is_binary(str) do
    rules
    |> Enum.reduce(str, fn %{src: src, replacer: replacer}, str ->
      String.replace(str, replace_string(src), replacer)
    end)
  end

  defp macro_prefix do
    "${"
  end

  defp macro_suffix do
    "}"
  end

  defp replace_string(src) do
    macro_prefix() <> src <> macro_suffix()
  end
end
