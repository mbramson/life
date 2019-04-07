defmodule Life.Resolver.UnrolledGridTest do
  use ExUnit.Case, async: true

  import Life.Resolver.UnrolledGrid

  describe "cell_to_right/4" do
    test "returns 0 for an empty list" do
      assert cell_to_right({}, 0, 0, 0) == 0
    end

    test "returns 0 for single cell" do
      assert cell_to_right({0}, 0, 1, 1) == 0
    end

    test "returns 0 if cell to right is 0" do
      assert cell_to_right({0, 0}, 0, 1, 2) == 0
    end

    test "returns 1 if cell to right is 1" do
      assert cell_to_right({0, 1}, 0, 1, 2) == 1
    end

    test "returns 0 if cell is on right border and another row exists" do
      assert cell_to_right({0, 1, 1, 1}, 1, 2, 2) == 0
    end

    test "returns 0 if cell is on right border and another row exists with more data" do
      assert cell_to_right({0, 1, 1, 1, 1, 1}, 2, 2, 3) == 0
    end
  end

  describe "cell_to_left/4" do
    test "returns 0 for an empty list" do
      assert cell_to_left({}, 0, 0, 0) == 0
    end

    test "returns 0 for single cell" do
      assert cell_to_left({0}, 0, 1, 1) == 0
    end

    test "returns 0 if cell to left is 0" do
      assert cell_to_left({0, 0}, 1, 1, 2) == 0
    end

    test "returns 1 if cell to left is 1" do
      assert cell_to_left({1, 0}, 1, 1, 2) == 1
    end

    test "returns 0 if cell is on left border of first row" do
      assert cell_to_left({1, 1, 1, 1}, 0, 2, 2) == 0
    end

    test "returns 0 if cell is on left border of second row" do
      assert cell_to_left({1, 1, 1, 1}, 2, 2, 2) == 0
    end

    test "returns 0 if cell is on elft border of second row with more data" do
      assert cell_to_left({1, 1, 1, 1, 1, 1}, 3, 2, 3) == 0
    end
  end

  describe "cell_above/4" do
    test "returns 0 for an empty list" do
      assert cell_above({}, 0, 0, 0) == 0
    end

    test "returns 0 for single cell" do
      assert cell_above({1}, 0, 1, 1) == 0
    end

    test "returns 0 if cell is in first row" do
      assert cell_above({1, 1, 1, 1}, 1, 1, 4) == 0
    end

    test "returns 0 if cell above is 0" do
      assert cell_above({1, 0, 1, 1}, 3, 2, 2) == 0
    end

    test "returns 1 if cell above is 1" do
      assert cell_above({0, 1, 0, 0}, 3, 2, 2) == 1
    end

    test "returns 1 if cell above is 1 and cell is on left border" do
      assert cell_above({1, 0, 0, 0}, 2, 2, 2) == 1
    end
  end

  describe "cell_below/4" do
    test "returns 0 for an empty list" do
      assert cell_below({}, 0, 0, 0) == 0
    end

    test "returns 0 for single cell" do
      assert cell_below({1}, 0, 1, 1) == 0
    end

    test "returns 0 if cell is in single row" do
      assert cell_below({1, 1, 1, 1}, 0, 1, 4) == 0
    end

    test "returns 0 if cell is in last row" do
      assert cell_below({1, 1, 1, 1}, 2, 2, 2) == 0
      assert cell_below({1, 1, 1, 1}, 3, 2, 2) == 0
    end

    test "returns 1 if cell below is 1" do
      assert cell_below({0, 0, 1, 0}, 0, 2, 2) == 1
      assert cell_below({0, 0, 0, 1}, 1, 2, 2) == 1
    end

    test "returns 0 if cell below is 0" do
      assert cell_below({1, 1, 0, 1}, 0, 2, 2) == 0
      assert cell_below({1, 1, 1, 0}, 1, 2, 2) == 0
    end
  end

  describe "cell_above_left/4" do
    test "returns 0 for an empty list" do
      assert cell_above_left({}, 0, 0, 0) == 0
    end

    test "returns 0 for single cell" do
      assert cell_above_left({1}, 0, 1, 1) == 0
    end

    test "returns 0 for cell on left border" do
      assert cell_above_left({1, 1, 1, 1}, 2, 2, 2) == 0
    end

    test "returns 0 for cell on top border" do
      assert cell_above_left({1, 1, 1, 1}, 1, 2, 2) == 0
    end

    test "returns 0 for cell in top left corner" do
      assert cell_above_left({1, 1, 1, 1}, 0, 2, 2) == 0
    end

    test "returns 1 if cell above left is 1" do
      assert cell_above_left({1, 0, 0, 0}, 3, 2, 2) == 1
    end

    test "returns 0 if cell above left is 0" do
      assert cell_above_left({0, 1, 1, 1}, 3, 2, 2) == 0
    end
  end

  describe "cell_above_right/4" do
    test "returns 0 for an empty list" do
      assert cell_above_right({}, 0, 0, 0) == 0
    end

    test "returns 0 for single cell" do
    end
  end

  describe "cell_below_left/4" do
    test "returns 0 for an empty list" do
      assert cell_below_left({}, 0, 0, 0) == 0
    end

    test "returns 0 for single cell" do
    end
  end

  describe "cell_below_right/4" do
    test "returns 0 for an empty list" do
      assert cell_below_right({}, 0, 0, 0) == 0
    end

    test "returns 0 for single cell" do
    end
  end
end
