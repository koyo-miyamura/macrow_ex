defmodule MacrowEx.Helper do
  @doc """
  MacrowEx helper functions.
  """
  def do_apply(str, rules, context \\ nil) do
    rules
    |> Enum.reduce(str, fn %{src: src, replacer_name: replacer_name, mod: mod}, str ->
      String.replace(str, replace_string(src), fn _ -> replace(mod, replacer_name, context) end)
    end)
  end

  def macro_prefix do
    "${"
  end

  def macro_suffix do
    "}"
  end

  def replace_string(src) do
    macro_prefix() <> src <> macro_suffix()
  end

  defp replace(mod, replacer_name, nil) do
    apply(mod, replacer_name, [])
    |> check_if_string()
  end

  defp replace(mod, replacer_name, context) do
    apply(mod, replacer_name, [context])
    |> check_if_string()
  end

  defp check_if_string(result) when is_binary(result) do
    result
  end

  defp check_if_string(_result) do
    raise MacrowEx.RulesFunctionMustReturnStringError
  end
end
