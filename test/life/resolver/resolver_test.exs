defmodule Life.ResolverTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  import Life.Resolver

  describe "step/1" do
    test "an empty grid returns an empty grid" do
      assert step([]) == []
    end

    test "single dead cell remains dead" do
      assert step([[0]]) == [[0]]
    end

    test "single live cell becomes dead" do
      assert step([[1]]) == [[0]]
    end

    test "four live cells in square stay live" do
      assert step([[1, 1], [1, 1]]) == [[1, 1], [1, 1]]
    end

    test "four live cells in a row result in two dying" do
      assert step([[1, 1, 1, 1]]) == [[0, 1, 1, 0]]
    end

    # [1, 1] -> [1, 0]
    # [1, 0]    [0, 0]
    test "three live cells in square result in two dying" do
      assert step([[1, 1], [1, 0]]) == [[1, 0], [0, 0]]
    end

    test "cells with two diagonal neighbors live" do
      assert step([[1, 0, 0], [0, 1, 0], [0, 0, 1]]) ==
        [[0, 0, 0], [0, 1, 0], [0, 0, 0]]
      assert step([[0, 0, 1], [0, 1, 0], [1, 0, 0]]) ==
        [[0, 0, 0], [0, 1, 0], [0, 0, 0]]
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
