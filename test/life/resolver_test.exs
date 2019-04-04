defmodule Life.ResolverTest do
  use ExUnit.Case, async: true

  import Life.Resolver

  describe "step/1" do
    test "an empty grid returns an empty grid" do
      assert step([]) == []
    end
  end
end
