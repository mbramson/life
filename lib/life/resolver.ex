defmodule Life.Resolver do
  @moduledoc """
  Contains functions useful for resolving a Conway's Game of Life step.
  """

  def step(grid) do
    neighbor_count_grid = calculate_active_neighbor_counts(grid)
    IO.inspect neighbor_count_grid, label: "neighbor_count_grid"
    grid
  end

  defp calculate_active_neighbor_counts([]), do: []
  defp calculate_active_neighbor_counts([first_row | [second_row | _] = second_and_later_rows]) do
    first_row_active_neighbors =
      calculate_active_neighbors_of_row(nil, first_row, second_row)
  end
  #TODO Pattern match on rows with row before and after

  defp calculate_active_neighbors_of_row(nil, row, row_after) do
    calculate_next_step_for_two_rows(row, row_after)
  end
  defp calculate_active_neighbors_of_row(row_before, row, nil) do
    calculate_next_step_for_two_rows(row, row_before)
  end


  # Begins active neighbor calculation for a row and a single other row.  To be
  # used for the first row and the last row. other_row can be before or after
  # the row in question, it doesn't matter.
  defp calculate_next_step_for_two_rows(
    [current_cell | [second_cell | _] = second_and_later_cells],
    [other_row_first_cell | [other_row_second_cell | _] = other_row_second_and_later_cells]
  ) do
    alive_neighbors = second_cell + other_row_first_cell + other_row_second_cell

    current_cell_alive_after_step =
      if cell_alive_next_step?(current_cell, alive_neighbors), do: 1, else: 0

    #TODO reduce across the rest of the row
  end

  def cell_alive_next_step?(0, 3), do: true
  def cell_alive_next_step?(0, _), do: false
  def cell_alive_next_step?(1, 2), do: true
  def cell_alive_next_step?(1, 3), do: true
  def cell_alive_next_step?(1, _), do: false
end
