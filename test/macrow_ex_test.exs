defmodule MacrowExTest do
  use ExUnit.Case
  doctest MacrowEx

  test "greets the world" do
    assert MacrowEx.hello() == :world
  end
end
