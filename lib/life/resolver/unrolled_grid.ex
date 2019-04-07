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

  def cell_to_right({}, _, _), do: 0
  def cell_to_right(unrolled_grid, position, columns) do
    if on_right_border(position, columns) do
      0
    else
      elem(unrolled_grid, position + 1)
    end
  end

  def cell_to_left({}, _, _), do: 0
  def cell_to_left(unrolled_grid, position, columns) do
    if on_left_border(position, columns) do
      0
    else
      elem(unrolled_grid, position - 1)
    end
  end

  def cell_above({}, _, _), do: 0
  def cell_above(unrolled_grid, position, columns) do
    if on_top_border(position, columns) do
      0
    else
      elem(unrolled_grid, position - columns)
    end
  end

  def cell_below({}, _, _), do: 0
  def cell_below(unrolled_grid, position, columns) do
    if on_lower_border(position, columns, unrolled_grid) do
      0
    else
      elem(unrolled_grid, position + columns)
    end
  end

  def cell_above_left({}, _, _), do: 0
  def cell_above_left(unrolled_grid, position, columns) do
    if on_top_border(position, columns) or on_left_border(position, columns) do
      0
    else
      elem(unrolled_grid, position - columns - 1)
    end
  end

  def cell_above_right({}, _, _), do: 0
  def cell_above_right(unrolled_grid, position, columns) do
    if on_top_border(position, columns) or on_right_border(position, columns) do
      0
    else
      elem(unrolled_grid, position - columns + 1)
    end
  end

  def cell_below_left({}, _, _), do: 0
  def cell_below_left(unrolled_grid, position, columns) do
    if on_lower_border(position, columns, unrolled_grid) or on_left_border(position, columns) do
      0
    else
      elem(unrolled_grid, position + columns - 1)
    end
  end

  def cell_below_right({}, _, _), do: 0
  def cell_below_right(unrolled_grid, position, columns) do
    if on_lower_border(position, columns, unrolled_grid) or on_right_border(position, columns) do
      0
    else
      elem(unrolled_grid, position + columns + 1)
    end
  end

  defp on_right_border(position, columns) do
    rem(position, columns) == columns - 1
  end

  defp on_left_border(position, columns) do
    rem(position, columns) == 0
  end

  defp on_top_border(position, columns) do
    position < columns
  end

  defp on_lower_border(position, columns, unrolled_grid) do
    position >= tuple_size(unrolled_grid) - columns
  end
end
