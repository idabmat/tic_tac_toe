defmodule TicTacToeTest do
  use ExUnit.Case

  describe "Original game" do
    setup do
      {:ok, pid} = TicTacToe.new_game(:original)
      %{pid: pid}
    end

    test "play a game", %{pid: pid} do
      game = TicTacToe.game_state(pid)
      play_original_game(game.current_player, pid)
    end
  end

  describe "Notakto game" do
    setup do
      {:ok, pid} = TicTacToe.new_game(:notakto)
      %{pid: pid}
    end

    test "play a game", %{pid: pid} do
      game = TicTacToe.game_state(pid)
      play_notakto_game(game.current_player, pid)
    end
  end

  describe "Misere game" do
    setup do
      {:ok, pid} = TicTacToe.new_game(:misere)
      %{pid: pid}
    end

    test "play a game", %{pid: pid} do
      game = TicTacToe.game_state(pid)
      play_misere_game(game.current_player, pid)
    end
  end

  def play_original_game(:computer, pid) do
    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 5)

    assert game.board == [
             [:computer, nil, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, :computer, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 3)

    assert game.board == [
             [:computer, :computer, :player1],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, :computer, :player1],
             [nil, :player1, nil],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 4)

    assert game.board == [
             [:computer, :computer, :player1],
             [:player1, :player1, nil],
             [:computer, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, :computer, :player1],
             [:player1, :player1, :computer],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 8)

    assert game.board == [
             [:computer, :computer, :player1],
             [:player1, :player1, :computer],
             [:computer, :player1, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, :computer, :player1],
             [:player1, :player1, :computer],
             [:computer, :player1, :computer]
           ]

    assert game.winner == :draw
  end

  def play_original_game(:player1, pid) do
    game = TicTacToe.player_move(pid, 5)

    assert game.board == [
             [nil, nil, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, nil, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 3)

    assert game.board == [
             [:computer, nil, :player1],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, nil, :player1],
             [nil, :player1, nil],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 4)

    assert game.board == [
             [:computer, nil, :player1],
             [:player1, :player1, nil],
             [:computer, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, nil, :player1],
             [:player1, :player1, :computer],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 2)

    assert game.board == [
             [:computer, :player1, :player1],
             [:player1, :player1, :computer],
             [:computer, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, :player1, :player1],
             [:player1, :player1, :computer],
             [:computer, :computer, nil]
           ]

    game = TicTacToe.player_move(pid, 9)

    assert game.board == [
             [:computer, :player1, :player1],
             [:player1, :player1, :computer],
             [:computer, :computer, :player1]
           ]

    assert game.winner == :draw
  end

  def play_notakto_game(:computer, pid) do
    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 5)

    assert game.board == [
             [:computer, nil, nil],
             [nil, :player1, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:computer, nil, nil],
             [nil, :player1, nil],
             [nil, nil, :computer]
           ]

    assert game.winner == :computer
  end

  def play_notakto_game(:player1, pid) do
    game = TicTacToe.player_move(pid, 1)

    assert game.board == [
             [:player1, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:player1, :computer, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 3)

    assert game.board == [
             [:player1, :computer, :player1],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    assert game.winner == :player1
    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:player1, :computer, :player1],
             [nil, nil, nil],
             [nil, nil, nil]
           ]
  end

  def play_misere_game(:computer, pid) do
    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [nil, nil, nil],
             [nil, :computer, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 1)

    assert game.board == [
             [:player1, nil, nil],
             [nil, :computer, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:player1, nil, nil],
             [nil, :computer, nil],
             [nil, nil, :computer]
           ]

    game = TicTacToe.player_move(pid, 3)

    assert game.board == [
             [:player1, nil, :player1],
             [nil, :computer, nil],
             [nil, nil, :computer]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:player1, nil, :player1],
             [nil, :computer, :computer],
             [nil, nil, :computer]
           ]

    game = TicTacToe.player_move(pid, 2)

    assert game.board == [
             [:player1, :player1, :player1],
             [nil, :computer, :computer],
             [nil, nil, :computer]
           ]

    assert game.winner == :computer
  end

  def play_misere_game(:player1, pid) do
    game = TicTacToe.player_move(pid, 1)

    assert game.board == [
             [:player1, nil, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:player1, :computer, nil],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 3)

    assert game.board == [
             [:player1, :computer, :player1],
             [nil, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:player1, :computer, :player1],
             [:computer, nil, nil],
             [nil, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 6)

    assert game.board == [
             [:player1, :computer, :player1],
             [:computer, nil, :player1],
             [nil, nil, nil]
           ]

    game = TicTacToe.computer_move(pid)

    assert game.board == [
             [:player1, :computer, :player1],
             [:computer, nil, :player1],
             [:computer, nil, nil]
           ]

    game = TicTacToe.player_move(pid, 9)

    assert game.board == [
             [:player1, :computer, :player1],
             [:computer, nil, :player1],
             [:computer, nil, :player1]
           ]

    assert game.winner == :computer
  end
end
