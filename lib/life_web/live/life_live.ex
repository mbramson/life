defmodule LifeWeb.LifeLive do
  use Phoenix.LiveView

  alias Life.Resolver

  def render(assigns) do
    ~L"""
    <h1>Conway's Game of Life!</h1>
    <div
      class="life-grid-container"
      style="
        grid-template-columns: repeat(<%= @columns %>, 1fr);
        grid-template-rows: repeat(<%= @rows %>, 1fr);
      "
    >
      <%= for {row, row_num} <- Enum.with_index(@grid) do %>
        <%= for {cell, col_num} <- Enum.with_index(row) do %>
          <div phx-click="toggle_cell" phx-value="<%= "#{row_num} #{col_num}" %>" class="life-grid-item">
            <%= cell %>
          </div>
        <% end %>
      <% end %>
    </div>
    <div class="centered">
      <button phx-click="resolve_step">Resolve Step</button>
    </div>
    <h3 class="centered">Rows</h3>
    <div class="three-element-grid-container">
      <button class="grid-item" phx-click="less_rows">Less</button>
      <div class="grid-item"><%= @rows %></div>
      <button class="grid-item" phx-click="more_rows">More</button>
    </div>
    <h3 class="centered">Columns</h3>
    <div class="three-element-grid-container">
      <button class="grid-item" phx-click="less_columns">Less</button>
      <div class="grid-item"><%= @columns %></div>
      <button class="grid-item" phx-click="more_columns">More</button>
    </div>
    """
  end

  def mount(_session, socket) do
    initialized_socket =
      socket
      |> assign_rows(6)
      |> assign_columns(6)
      |> assign_initial_grid()

    {:ok, initialized_socket}
  end

  defp assign_rows(socket, rows) do
    assign(socket, rows: rows)
  end

  defp assign_columns(socket, columns) do
    assign(socket, columns: columns)
  end

  defp assign_initial_grid(socket) do
    rows = socket.assigns[:rows]
    columns = socket.assigns[:columns]

    row = List.duplicate(0, columns)
    grid = List.duplicate(row, rows)

    assign(socket, grid: grid)
  end

  # LiveView Callbacks

  def handle_event("resolve_step", _payload, socket) do
    grid = socket.assigns[:grid]
    new_grid = Resolver.step(grid)
    {:noreply, assign(socket, grid: new_grid)}
  end

  def handle_event("toggle_cell", payload, socket) do
    [row_index, column_index] = String.split(payload)

    {row_index, _} = Integer.parse(row_index)
    {column_index, _} = Integer.parse(column_index)

    grid = socket.assigns[:grid]

    current_row = grid
                  |> Enum.at(row_index)

    current_cell_value = current_row
                         |> Enum.at(column_index)

    new_cell_value = opposite_cell_value(current_cell_value)

    new_row = List.replace_at(current_row, column_index, new_cell_value)

    new_grid = List.replace_at(grid, row_index, new_row)

    {:noreply, assign(socket, grid: new_grid)}
  end

  def handle_event("less_rows", _payload, socket) do
    rows = socket.assigns[:rows]
    new_rows = rows |> subtract_one_with_floor

    grid = socket.assigns[:grid]
    new_grid = Enum.take(grid, new_rows)

    {:noreply, assign(socket, rows: new_rows, grid: new_grid)}
  end

  def handle_event("more_rows", _payload, socket) do
    rows = socket.assigns[:rows]
    new_rows = rows + 1

    columns = socket.assigns[:columns]
    grid = socket.assigns[:grid]
    new_grid = grid ++ [List.duplicate(0, columns)]

    {:noreply, assign(socket, rows: new_rows, grid: new_grid)}
  end

  def handle_event("less_columns", _payload, socket) do
    columns = socket.assigns[:columns]
    new_columns = columns |> subtract_one_with_floor

    grid = socket.assigns[:grid]
    new_grid = Enum.map(grid, fn row -> Enum.take(row, new_columns) end)

    {:noreply, assign(socket, columns: new_columns, grid: new_grid)}
  end

  def handle_event("more_columns", _payload, socket) do
    columns = socket.assigns[:columns]
    new_columns = columns + 1

    grid = socket.assigns[:grid]
    new_grid = Enum.map(grid, fn row -> row ++ [0] end)
    {:noreply, assign(socket, columns: new_columns, grid: new_grid)}
  end

  defp opposite_cell_value(0), do: 1
  defp opposite_cell_value(1), do: 0

  defp subtract_one_with_floor(1), do: 1
  defp subtract_one_with_floor(integer), do: integer - 1
end
