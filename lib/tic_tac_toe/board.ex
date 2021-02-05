defmodule TicTacToe.Board do
  @moduledoc """
  Functions for interacting with a board.
  """

  @type t :: triplet(triplet())
  @type triplet(triple) :: [triple]
  @type triplet :: [nil | player()]
  @type player :: :player1 | :computer
  @type position :: 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
  @type point :: {0 | 1 | 2, 0 | 1 | 2}

  @spec new :: t()
  def new do
    [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  @spec receive_move(t(), player(), position()) :: t()
  def receive_move(board, _, position) when position not in 1..9, do: board

  def receive_move(board, player, position) do
    point = indexes_from_position(position, board)
    empty? = cell_empty?(board, point)
    insert_into(board, point, player, empty?)
  end

  @spec insert_into(t(), point(), player(), boolean()) :: t()
  defp insert_into(board, _, _, false), do: board

  defp insert_into(board, point = {row_index, _}, player, _empty) do
    new_row = build_new_row(board, point, player)
    board |> List.replace_at(row_index, new_row)
  end

  @spec build_new_row(t(), point(), player()) :: t()
  defp build_new_row(board, {row_index, column_index}, player) do
    board
    |> Enum.at(row_index)
    |> List.replace_at(column_index, player)
  end

  @spec cell_empty?(t(), point()) :: boolean()
  defp cell_empty?(board, {row_index, column_index}) do
    board
    |> Enum.at(row_index)
    |> Enum.at(column_index) == nil
  end

  @spec indexes_from_position(position(), t()) :: point()
  def indexes_from_position(position, board) do
    row_index = div(position - 1, size(board))
    column_index = rem(position - 1, size(board))
    {row_index, column_index}
  end

  @spec position_from_indexes(point(), t()) :: position()
  def position_from_indexes({row_index, column_index}, board) do
    row_index * size(board) + column_index + 1
  end

  @spec row(t(), position()) :: triplet()
  def row(board, position), do: board |> Enum.at(position - 1)

  @spec rows(t()) :: t()
  def rows(board), do: board

  @spec columns(t()) :: t()
  def columns(board), do: board |> transpose |> rows

  @spec column(t(), position()) :: triplet()
  def column(board, position), do: board |> transpose |> row(position)

  @spec diagonal(t(), 1 | 2) :: triplet()
  def diagonal(board, 1) do
    for x <- 0..(size(board) - 1), do: board |> Enum.at(x) |> Enum.at(x)
  end

  def diagonal(board, 2) do
    for {x, y} <- Enum.zip(0..(size(board) - 1), (size(board) - 1)..0),
        do: board |> Enum.at(x) |> Enum.at(y)
  end

  @spec diagonals(t()) :: [triplet()]
  def diagonals(board), do: [diagonal(board, 1), diagonal(board, 2)]

  @spec empty_cells(t()) :: [point()]
  def empty_cells(board) do
    for x <- 0..(size(board) - 1),
        y <- 0..(size(board) - 1),
        board |> Enum.at(x) |> Enum.at(y) == nil,
        do: {x, y}
  end

  @spec triplets(t()) :: [triplet()]
  def triplets(board) do
    rows(board) ++ columns(board) ++ diagonals(board)
  end

  @spec size(t()) :: non_neg_integer()
  def size(board) do
    length(board)
  end

  @spec transpose(t()) :: t()
  defp transpose(board) do
    board
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
