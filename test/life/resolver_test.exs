defmodule Life.ResolverTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  import Life.Resolver

  describe "step/1" do
    test "an empty grid returns an empty grid" do
      assert step([]) == []
    end
  end

  describe "cell_alive_next_step?/2" do
    property "live cell with fewer than two live neighbors dies" do
      check all alive_neighbors <- integer(0..1) do
        refute cell_alive_next_step?(1, alive_neighbors)
      end
    end

    property "live cell with two or three live neighbors lives" do
      check all alive_neighbors <- integer(2..3) do
        assert cell_alive_next_step?(1, alive_neighbors)
      end
    end


    property "live cell with more than three live neighbors dies" do
      check all alive_neighbors <- integer(4..8) do
        refute cell_alive_next_step?(1, alive_neighbors)
      end
    end

    property "dead cell with exactly three live neighbors lives" do
      assert cell_alive_next_step?(0, 3)
    end

    property "dead cell with less than three live neighbors dies" do
      check all alive_neighbors <- integer(0..2) do
        refute cell_alive_next_step?(0, alive_neighbors)
      end
    end

    property "dead cell with more than three live neighbors dies" do
      check all alive_neighbors <- integer(4..8) do
        refute cell_alive_next_step?(0, alive_neighbors)
      end
    end
  end
end
