defmodule TicTacToeTest do
  use ExUnit.Case

  test "play an original game" do
    game = TicTacToe.new_game(:original)
    play_original_game(game)
  end

  test "play a notakto game" do
    game = TicTacToe.new_game(:notakto)
    play_notakto_game(game)
  end

  test "play a misere game" do
    game = TicTacToe.new_game(:misere)
    play_misere_game(game)
  end

  defp play_original_game(game = %{current_player: :computer}) do
    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(game, 5)

    assert game.board == [
             [:computer, nil, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, :computer, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(game, 3)

    assert game.board == [
             [:computer, :computer, :player1],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, :computer, :player1],
             [nil, :player1, nil],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(game, 4)

    assert game.board == [
             [:computer, :computer, :player1],
             [:player1, :player1, nil],
             [:computer, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, :computer, :player1],
             [:player1, :player1, :computer],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(game, 8)

    assert game.board == [
             [:computer, :computer, :player1],
             [:player1, :player1, :computer],
             [:computer, :player1, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, :computer, :player1],
             [:player1, :player1, :computer],
             [:computer, :player1, :computer]
           ]

    assert game.winner == :draw
  end

  defp play_original_game(game = %{current_player: :player1}) do
    game = TicTacToe.player_move(game, 5)

    assert game.board == [
             [nil, nil, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, nil, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(game, 3)

    assert game.board == [
             [:computer, nil, :player1],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, nil, :player1],
             [nil, :player1, nil],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(game, 4)

    assert game.board == [
             [:computer, nil, :player1],
             [:player1, :player1, nil],
             [:computer, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, nil, :player1],
             [:player1, :player1, :computer],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(game, 2)

    assert game.board == [
             [:computer, :player1, :player1],
             [:player1, :player1, :computer],
             [:computer, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, :player1, :player1],
             [:player1, :player1, :computer],
             [:computer, :computer, nil]
           ]

    game = TicTacToe.player_move(game, 9)

    assert game.board == [
             [:computer, :player1, :player1],
             [:player1, :player1, :computer],
             [:computer, :computer, :player1]
           ]

    assert game.winner == :draw
  end

  defp play_notakto_game(game = %{current_player: :computer}) do
    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(game, 5)

    assert game.board == [
             [:computer, nil, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:computer, nil, nil],
             [nil, :player1, nil],
             [nil, nil, :computer]
           ]

    assert game.winner == :computer
  end

  defp play_notakto_game(game = %{current_player: :player1}) do
    game = TicTacToe.player_move(game, 1)

    assert game.board == [
             [:player1, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:player1, :computer, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(game, 3)

    assert game.board == [
             [:player1, :computer, :player1],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    assert game.winner == :player1
    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:player1, :computer, :player1],
             [nil, nil, nil],
             [nil, nil, nil]
           ]
  end

  defp play_misere_game(game = %{current_player: :computer}) do
    game = TicTacToe.computer_move(game)

    assert game.board == [
             [nil, nil, nil],
             [nil, :computer, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(game, 1)

    assert game.board == [
             [:player1, nil, nil],
             [nil, :computer, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:player1, nil, nil],
             [nil, :computer, nil],
             [nil, nil, :computer]
           ]

    game = TicTacToe.player_move(game, 3)

    assert game.board == [
             [:player1, nil, :player1],
             [nil, :computer, nil],
             [nil, nil, :computer]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:player1, nil, :player1],
             [nil, :computer, :computer],
             [nil, nil, :computer]
           ]

    game = TicTacToe.player_move(game, 2)

    assert game.board == [
             [:player1, :player1, :player1],
             [nil, :computer, :computer],
             [nil, nil, :computer]
           ]

    assert game.winner == :computer
  end

  defp play_misere_game(game = %{current_player: :player1}) do
    game = TicTacToe.player_move(game, 1)

    assert game.board == [
             [:player1, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:player1, :computer, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(game, 3)

    assert game.board == [
             [:player1, :computer, :player1],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:player1, :computer, :player1],
             [:computer, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(game, 6)

    assert game.board == [
             [:player1, :computer, :player1],
             [:computer, nil, :player1],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(game)

    assert game.board == [
             [:player1, :computer, :player1],
             [:computer, nil, :player1],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(game, 9)

    assert game.board == [
             [:player1, :computer, :player1],
             [:computer, nil, :player1],
             [:computer, nil, :player1]
           ]

    assert game.winner == :computer
  end
end
