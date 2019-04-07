defmodule Life.Resolver do
  @moduledoc """
  Contains functions useful for resolving a Conway's Game of Life step.
  """

  alias Life.Resolver.UnrolledGrid

  def step(grid) do
    columns = columns_in(grid)

    unrolled_grid_tuple = UnrolledGrid.unroll(grid)

    next_step_unrolled_grid =
      calculate_neighbors(unrolled_grid_tuple, columns)

    UnrolledGrid.roll(next_step_unrolled_grid, columns)
  end

  defp calculate_neighbors(unrolled_grid, columns) do
    unrolled_grid
    |> reduce_grid(0, columns, [])
    |> Enum.reverse
  end

  defp reduce_grid(unrolled_grid, current_cell, _, acc)
    when tuple_size(unrolled_grid) == current_cell do
    acc
  end
  defp reduce_grid(unrolled_grid, current_cell, columns, acc) do
    current_cell_value = elem(unrolled_grid, current_cell)

    neighbors =
      UnrolledGrid.cell_to_left(unrolled_grid, current_cell, columns) +
      UnrolledGrid.cell_to_right(unrolled_grid, current_cell, columns) +
      UnrolledGrid.cell_above(unrolled_grid, current_cell, columns) +
      UnrolledGrid.cell_below(unrolled_grid, current_cell, columns) +
      UnrolledGrid.cell_above_left(unrolled_grid, current_cell, columns) +
      UnrolledGrid.cell_above_right(unrolled_grid, current_cell, columns) +
      UnrolledGrid.cell_below_left(unrolled_grid, current_cell, columns) +
      UnrolledGrid.cell_below_right(unrolled_grid, current_cell, columns)

    next_step_cell_value =
      if cell_alive_next_step?(current_cell_value, neighbors) do
        1
      else
        0
      end

    reduce_grid(unrolled_grid, current_cell + 1, columns, [next_step_cell_value | acc])
  end

  defp columns_in([]), do: 0
  defp columns_in([row | _]), do: length(row)

  def cell_alive_next_step?(0, 3), do: true
  def cell_alive_next_step?(0, _), do: false
  def cell_alive_next_step?(1, 2), do: true
  def cell_alive_next_step?(1, 3), do: true
  def cell_alive_next_step?(1, _), do: false
end
