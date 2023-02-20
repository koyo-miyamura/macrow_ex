defmodule MacrowEx.Helper do
  @doc """
  MacrowEx helper functions.
  """
  def do_apply(str, rules, macro_prefix, macro_suffix, context \\ nil) do
    rules
    |> Enum.reduce(str, fn %{src: src, replacer_name: replacer_name, mod: mod}, str ->
      String.replace(str, macro_prefix <> src <> macro_suffix, fn _ ->
        replace(mod, replacer_name, context)
      end)
    end)
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
