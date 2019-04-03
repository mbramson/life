defmodule LifeWeb.LifeLive do
  use Phoenix.LiveView

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
      <%= for row <- @grid do %>
        <%= for cell <- row do %>
          <div class="life-grid-item"><%= cell %></div>
        <%= end %>
      <% end %>
    </div>
    <h3 class="centered">Rows
      <div class="three-element-grid-container">
        <button class="grid-item" phx-click="less_rows">Less</button>
        <div class="grid-item"><%= @rows %></div>
        <button class="grid-item" phx-click="more_rows">More</button>
      </div>
    </h3>
    <h3 class="centered">Columns
      <div class="three-element-grid-container">
        <button class="grid-item" phx-click="less_columns">Less</button>
        <div class="grid-item"><%= @columns %></div>
        <button class="grid-item" phx-click="more_columns">More</button>
      </div>
    </h3>
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

  defp subtract_one_with_floor(1), do: 1
  defp subtract_one_with_floor(integer), do: integer - 1
end
