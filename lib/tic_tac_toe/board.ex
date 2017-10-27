defmodule TicTacToe.Board do
  def new(), do: new(3)
  def new(3) do
    [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end
  def new(size) do
    new(size - 1)
    |> Enum.map(&prepend_nil/1)
    |> duplicate_first_row
  end

  defp prepend_nil(row) do
    [nil | row]
  end

  defp duplicate_first_row(row = [h|_t]) do
    [h | row]
  end

  def receive_move(board, _, position) when position not in 1..9, do: board
  def receive_move(board, player, position) do
    { row_index, column_index } = indexes_from_position(position, board)
    empty? = cell_empty?(board, row_index, column_index)
    insert_into(board, row_index, column_index, player, empty?)
  end

  def insert_into(board, _, _, _, false), do: board
  def insert_into(board, row_index, column_index, player, _empty) do
    new_row = build_new_row(board, row_index, column_index, player)
    board |> List.replace_at(row_index, new_row)
  end

  def build_new_row(board, row_index, column_index, player) do
    board
    |> Enum.at(row_index)
    |> List.replace_at(column_index, player)
  end

  def cell_empty?(board, row_index, column_index) do
    board
    |> Enum.at(row_index)
    |> Enum.at(column_index)
    == nil
  end

  def indexes_from_position(position, board) do
    row_index   = div(position - 1, size(board))
    column_index = rem(position - 1, size(board))
    { row_index, column_index }
  end

  def position_from_indexes({row_index, column_index}, board) do
    row_index * size(board) + column_index + 1
  end

  def row(board, position), do: board |> Enum.at(position - 1)
  def rows(board), do: board

  def columns(board), do: board |> transpose |> rows
  def column(board, position), do: board |> transpose |> row(position)

  def diagonal(board, 1) do
    for x <- 0..(size(board) - 1), do: board |> Enum.at(x) |> Enum.at(x)
  end

  def diagonal(board, 2) do
    for {x, y} <- Enum.zip(0..(size(board) - 1), (size(board) - 1)..0),
        do: board |> Enum.at(x) |> Enum.at(y)
  end

  def diagonals(board), do: [diagonal(board, 1), diagonal(board, 2)]

  def empty_cells(board) do
    for x <- 0..(size(board) - 1), y <- 0..(size(board) - 1),
        board |> Enum.at(x) |> Enum.at(y) == nil,
        do: {x, y}
  end

  def triplets(board) do
    rows(board) ++ columns(board) ++ diagonals(board)
  end

  def size(board) do
    length(board)
  end

  defp transpose(board) do
    board
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
  end
end
