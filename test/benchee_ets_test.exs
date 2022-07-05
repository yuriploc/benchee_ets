defmodule BencheeEtsTest do
  use ExUnit.Case
  doctest BencheeEts

  test "greets the world" do
    assert BencheeEts.hello() == :world
  end
end
