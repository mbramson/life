defmodule Life.Resolver.UnrolledGrid do

  def unroll(grid) do
    grid
    |> Enum.flat_map(&(&1))
    |> List.to_tuple
  end

  def roll([], _), do: []
  def roll(unrolled_grid, columns) do
    Enum.chunk_every(unrolled_grid, columns)
  end

  def cell_to_right({}, _, _, _), do: 0
  def cell_to_right(unrolled_grid, current_cell_number, _rows, columns) do
    if rem(current_cell_number, columns) == columns - 1 do
      # cell is on right border
      0
    else
      elem(unrolled_grid, current_cell_number + 1)
    end
  end

  def cell_to_left({}, _, _, _), do: 0
  def cell_to_left(unrolled_grid, current_cell_number, _rows, columns) do
    if rem(current_cell_number, columns) == 0 do
      0
    else
      elem(unrolled_grid, current_cell_number - 1)
    end
  end

  def cell_above({}, _, _, _), do: 0
  def cell_above(unrolled_grid, current_cell_number, _rows, columns) do
    if current_cell_number < columns do
      0
    else
      elem(unrolled_grid, current_cell_number - columns)
    end
  end

  def cell_below({}, _, _, _), do: 0
  def cell_below(unrolled_grid, current_cell_number, _rows, columns) do
    if current_cell_number >= tuple_size(unrolled_grid) - columns do
      0
    else
      elem(unrolled_grid, current_cell_number + columns)
    end
  end

  def cell_above_left({}, _, _, _), do: 0
  def cell_above_left(unrolled_grid, current_cell_number, _rows, columns) do
    if current_cell_number < columns or rem(current_cell_number, columns) == 0 do
      0
    else
      elem(unrolled_grid, current_cell_number - columns - 1)
    end
  end

  def cell_above_right({}, _, _, _), do: 0

  def cell_below_left({}, _, _, _), do: 0

  def cell_below_right({}, _, _, _), do: 0
end
