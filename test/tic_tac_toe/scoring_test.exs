defmodule TicTacToe.ScoringTest do
  use ExUnit.Case
  alias TicTacToe.Scoring

  describe "Original TicTacToe game" do
    test "computer won" do
      game = %TicTacToe.Game{
        board: [
          [:computer, :computer, :computer],
          [nil, nil, nil],
          [nil, nil, nil],
        ]
      }
      assert Scoring.winner(game) == :computer
    end

    test "player won" do
      game = %TicTacToe.Game{
        board: [
          [:player1, :player1, :player1],
          [nil, nil, nil],
          [nil, nil, nil],
        ]
      }
      assert Scoring.winner(game) == :player1
    end

    test "draw won" do
      game = %TicTacToe.Game{
        board: [
          [:computer, :player1, :computer],
          [:computer, :player1, :computer],
          [:player1, :computer, :player1],
        ]
      }
      assert Scoring.winner(game) == :draw
    end

    test "no winner yet" do
      game = %TicTacToe.Game{
        board: [
          [:computer, :nil, :computer],
          [nil, nil, nil],
          [nil, nil, nil],
        ]
      }
      assert Scoring.winner(game) == nil
    end
  end

  describe "Notakto" do
    test "computer won" do
      game = %TicTacToe.Game{
        board: [
          [:computer, :player1, :computer],
          [nil, nil, nil],
          [nil, nil, nil],
        ],
        current_player: :player1,
        game_mode: :notakto
      }
      assert Scoring.winner(game) == :computer
    end

    test "player won" do
      game = %TicTacToe.Game{
        board: [
          [:computer, :player1, :computer],
          [nil, nil, nil],
          [nil, nil, nil],
        ],
        current_player: :computer,
        game_mode: :notakto
      }
      assert Scoring.winner(game) == :player1
    end

    test "no winner yet" do
      game = %TicTacToe.Game{
        board: [
          [:computer, :player1, nil],
          [nil, nil, nil],
          [nil, nil, nil],
        ],
        current_player: :computer,
        game_mode: :notakto
      }
      assert Scoring.winner(game) == nil
    end
  end

  describe "Misere" do
    test "computer won" do
      game = %TicTacToe.Game{
        board: [
          [:player1, :player1, :player1],
          [nil, nil, nil],
          [nil, nil, nil],
        ],
        game_mode: :misere
      }
      assert Scoring.winner(game) == :computer
    end
  end
end
