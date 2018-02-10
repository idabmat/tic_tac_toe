defmodule TicTacToe.GameTest do
  use ExUnit.Case
  alias TicTacToe.Game

  test "Starting a new game initializes an empty board" do
    assert Game.new().board == [
             [nil, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]
  end

  test "Starting a game has no winner" do
    assert Game.new().winner == nil
  end

  test "Starting a game initializes a player's turn" do
    assert Game.new().current_player in [:player1, :computer]
  end

  test "Identify when the computer won" do
    board = [
      [:computer, :computer, :computer],
      [nil, nil, nil],
      [nil, nil, nil]
    ]

    game = %Game{board: board} |> Game.score()
    assert game.winner == :computer
  end

  test "Identify when the player won" do
    board = [
      [nil, nil, :player1],
      [nil, :player1, nil],
      [:player1, nil, nil]
    ]

    game = %Game{board: board} |> Game.score()
    assert game.winner == :player1
  end

  test "Identify when the game ended in a draw" do
    board = [
      [:computer, :player1, :player1],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board} |> Game.score()
    assert game.winner == :draw
  end

  test "Identify when the game is not over" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board} |> Game.score()
    assert game.winner == nil
  end

  test "player can move on its turn" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board, current_player: :player1} |> Game.player_move(3)

    assert game.board == [
             [:computer, :player1, :player1],
             [:player1, :computer, :computer],
             [:player1, :computer, :player1]
           ]
  end

  test "player cannot move on computer turn" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board, current_player: :computer} |> Game.player_move(3)
    assert game.board == board
    assert game.current_player == :computer
  end

  test "computer can move on its turn" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board, current_player: :computer} |> Game.computer_move()

    assert game.board == [
             [:computer, :player1, :computer],
             [:player1, :computer, :computer],
             [:player1, :computer, :player1]
           ]
  end

  test "computer cannot move on player turn" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board, current_player: :player1} |> Game.computer_move()
    assert game.board == board
    assert game.current_player == :player1
  end

  test "invalid move does not change the board" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board} |> Game.player_move(1)
    assert game.board == board
  end

  test "valid move changes the player's turn" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board, current_player: :player1} |> Game.player_move(3)
    assert game.current_player == :computer
  end

  test "invalid move does not change the player's turn" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board, current_player: :player1} |> Game.player_move(1)
    assert game.current_player == :player1
  end

  test "valid move changes calculates the winner" do
    board = [
      [:computer, :player1, nil],
      [:player1, :computer, :computer],
      [:player1, :computer, :player1]
    ]

    game = %Game{board: board, current_player: :player1} |> Game.player_move(3)
    assert game.winner == :draw
  end

  test "game is over when there is a winner" do
    game = %Game{winner: :player1}
    assert Game.over?(game) == true
  end

  test "cannot move after game over" do
    board = [
      [:player1, :player1, :player1],
      [nil, nil, nil],
      [nil, nil, nil]
    ]

    game =
      %Game{winner: :player1, board: board, current_player: :computer} |> Game.computer_move()

    assert game.board == board
  end

  test "invalid moves does not change the current player" do
    game = %Game{winner: :player1, current_player: :computer} |> Game.computer_move()
    assert game.current_player == :computer
  end

  test "game is over when there is a draw" do
    game = %Game{winner: :draw}
    assert Game.over?(game) == true
  end

  test "game is not over otherwise" do
    game = %Game{winner: nil}
    assert Game.over?(game) == false
  end
end
