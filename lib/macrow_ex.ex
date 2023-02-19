defmodule MacrowEx do
  defmodule RulesFunctionMustReturnStringError do
    defexception message: "rules function must return string"
  end

  @moduledoc """
  Documentation for `MacrowEx`.
  """

  defmacro __using__(_opts) do
    quote do
      import MacrowEx, only: [rules: 2]
      Module.register_attribute(__MODULE__, :rules, accumulate: true)
      @before_compile MacrowEx
    end
  end

  defmacro rules(src, replacer) do
    replacer_name = String.to_atom(src <> "_replacer")

    quote do
      case unquote(replacer) |> Function.info() |> Keyword.get(:arity) do
        0 ->
          def unquote(replacer_name)(), do: unquote(replacer).()
          def unquote(replacer_name)(_), do: unquote(replacer).()

        1 ->
          def unquote(replacer_name)(context), do: unquote(replacer).(context)
      end

      @rules Macro.escape(%{
               src: unquote(src),
               replacer_name: unquote(replacer_name),
               mod: __MODULE__
             })
    end
  end

  defmacro __before_compile__(env) do
    rules = Module.get_attribute(env.module, :rules)

    quote do
      def apply(str, context \\ nil), do: MacrowEx.Helper.do_apply(str, unquote(rules), context)
    end
  end
end
