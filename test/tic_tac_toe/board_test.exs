defmodule TicTacToe.BoardTest do
  use ExUnit.Case
  alias TicTacToe.Board

  test "initializes an empty board" do
    empty_board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
    assert Board.new == empty_board
  end

  test "accepts a move" do
    board = Board.new()
    assert Board.receive_move(board, :player1, 1) == [
      [:player1, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  test "rejects invalid move" do
    board = [
      [:player1, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
    assert Board.receive_move(board, :computer, 1) == [
      [:player1, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  test "rejects out of bound moves" do
    board = [
      [:player1, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
    assert Board.receive_move(board, :computer, 11) == [
      [:player1, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  test "has rows" do
    row1 = [:player1, nil, nil]
    row2 = [nil, nil, nil]
    row3 = [nil, nil, :computer]
    board = [row1, row2, row3]
    assert Board.row(board, 1) == row1
    assert Board.row(board, 2) == row2
    assert Board.row(board, 3) == row3
    assert Board.rows(board) == [row1, row2, row3]
  end

  test "has columns" do
    board = [
      [:player1, nil, :player1],
      [nil, nil, nil],
      [nil, nil, :computer]
    ]
    column1 = [:player1, nil, nil]
    column2 = [nil, nil, nil]
    column3 = [:player1, nil, :computer]
    assert Board.column(board, 1) == column1
    assert Board.column(board, 2) == column2
    assert Board.column(board, 3) == column3
    assert Board.columns(board) == [column1, column2, column3]
  end

  test "has diagonals" do
    board = [
      [:player1, nil, :player1],
      [nil, nil, nil],
      [nil, nil, :computer]
    ]
    diagonal1 = [:player1, nil, :computer]
    diagonal2 = [:player1, nil, nil]
    assert Board.diagonal(board, 1) == diagonal1
    assert Board.diagonal(board, 2) == diagonal2
    assert Board.diagonals(board) == [diagonal1, diagonal2]
  end

  test "knows empty cells" do
    board = [
      [:player1, :computer, :player1],
      [nil, nil, :computer],
      [:player1, :computer, :player1]
    ]
    assert Board.empty_cells(board) == [{1, 0}, {1, 1}]
  end

  test "Splits rows, columns and diagonals" do
    board = [
      [:player1, :computer, :player1],
      [nil, nil, :computer],
      [:player1, :computer, :player1]
    ]
    assert Board.triplets(board) == [
      [:player1, :computer, :player1],
      [nil, nil, :computer],
      [:player1, :computer, :player1],
      [:player1, nil, :player1],
      [:computer, nil, :computer],
      [:player1, :computer, :player1],
      [:player1, nil, :player1],
      [:player1, nil, :player1]
    ]
  end
end
