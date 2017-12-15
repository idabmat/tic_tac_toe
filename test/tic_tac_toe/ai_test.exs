defmodule TicTacToe.AiTest do
  use ExUnit.Case
  alias TicTacToe.Ai
  alias TicTacToe.Game

  test "it knows where it can play" do
    board = [
      [:player1, :computer, :player1],
      [nil, nil, :computer],
      [:player1, :computer, :player1]
    ]
    assert %Game{board: board} |> Ai.playable_positions == [4, 5]
  end

  test "simulating a computer turn" do
    before_board = [
      [:player1, :computer, :player1],
      [nil, nil, :computer],
      [:player1, :computer, :player1]
    ]
    after_board = [
      [:player1, :computer, :player1],
      [:computer, nil, :computer],
      [:player1, :computer, :player1]
    ]
    game = %Game{board: before_board, current_player: :computer}
    assert Ai.simulate_move(game, 4) == %Game{winner: nil, board: after_board, current_player: :player1}
  end

  test "simulating a player turn" do
    before_board = [
      [:player1, :computer, :player1],
      [nil, nil, :computer],
      [:player1, :computer, :player1]
    ]
    after_board = [
      [:player1, :computer, :player1],
      [:player1, nil, :computer],
      [:player1, :computer, :player1]
    ]
    game = %Game{board: before_board, current_player: :player1}
    assert Ai.simulate_move(game, 4) == %Game{winner: :player1, board: after_board, current_player: :computer}
  end

  test "scores a win positively" do
    game = %Game{winner: :computer}
    assert Ai.score(game) == 1
  end

  test "scores a loss negatively" do
    game = %Game{winner: :player1}
    assert Ai.score(game) == -1
  end

  test "scores a draw as zero" do
    game = %Game{winner: :draw}
    assert Ai.score(game) == 0
  end

  test "plays to win" do
    board = [
      [:player1, :computer, :player1],
      [:player1, :computer, nil     ],
      [nil     , nil      , nil     ],
    ]
    game = %Game{board: board, current_player: :computer}
    assert Ai.choose_next_position(game) == 8
  end

  test "plays to defend itself" do
    board = [
      [nil      , :computer, :player1],
      [:computer, :computer, :player1],
      [:player1 , :player1 , nil     ],
    ]
    game = %Game{board: board, current_player: :computer}
    assert Ai.choose_next_position(game) == 9
  end

  test "dont pick losing moves" do
    board = [
      [nil, nil     , nil],
      [nil, :player1, nil],
      [nil, nil     , nil]
    ]
    game = %Game{board: board, current_player: :computer}
    assert Ai.choose_next_position(game) not in [2, 4, 6, 8]
  end

  test "pick winning strategy" do
    board = [
      [nil, :player1 , nil],
      [nil, :computer, nil],
      [nil, nil      , nil]
    ]
    game = %Game{board: board, current_player: :computer}
    assert Ai.choose_next_position(game) in [1, 3, 7, 9]
  end

  test "when playing misere it selects middle as first move" do
    board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
    game = %Game{board: board, current_player: :computer, game_mode: :misere}
    assert Ai.choose_next_position(game) == 5
  end
end
