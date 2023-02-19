defmodule MacrowEx do
  defmodule RulesFunctionMustReturnStringError do
    defexception message: "rules function must return string"
  end

  @moduledoc """
  `MacrowEx` provides DSL for defining rules of text replacing.

  ## Examples
  Define your module and write `use MacrowEx`.

  MacrowEx provides `rules/2` DSL to define replacement rules.

  The second argument is function to replace and must return string.

    defmodule MyMacrowEx do
      use MacrowEx

      rules "hoge", fn ->
        "ほげ"
      end

      rules "len", fn array ->
        length(array) |> Integer.to_string()
      end
    end

  Then `apply/1` `apply/2` function generates in your module.

    MyMacrowEx.apply("${hoge}")
    "ほげ"

    MyMacrowEx.apply("${hoge} length is ${len}")
    "ほげ length is 3"
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
