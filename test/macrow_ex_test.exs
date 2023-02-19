defmodule MacrowExTest do
  use ExUnit.Case
  doctest MacrowEx

  defmodule MyMacrowEx do
    use MacrowEx

    rules "hoge", fn ->
      "ほげ"
    end

    rules "len", fn array ->
      length(array) |> Integer.to_string()
    end

    rules "len_return_integer", fn array ->
      length(array)
    end
  end

  describe "apply" do
    test "replace pattern" do
      assert MyMacrowEx.apply("${hoge}") == "ほげ"
      assert MyMacrowEx.apply("${hoge}", []) == "ほげ"
    end

    test "replace multiple patterns" do
      assert MyMacrowEx.apply("hoge${hoge}hoge${hoge}") == "hogeほげhogeほげ"
    end

    test "replace multiple rules" do
      assert MyMacrowEx.apply("${hoge} length is ${len}", [1, 2, 3]) == "ほげ length is 3"
    end

    test "raise if rules function does not return string" do
      assert_raise MacrowEx.RulesFunctionShouldReturnStringError, fn ->
        MyMacrowEx.apply("${len_return_integer}", [])
      end
    end
  end
end
