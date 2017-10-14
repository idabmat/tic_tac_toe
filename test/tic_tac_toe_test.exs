defmodule TicTacToeTest do
  use ExUnit.Case

  setup do
    {:ok, pid} = TicTacToe.new_game()
    %{pid: pid}
  end

  test "play a game", %{pid: pid} do
    game = TicTacToe.game_state(pid)
    play_game(game.current_player, pid)
  end

  def play_game(:computer, pid) do
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, nil , nil],
      [nil      , nil , nil],
      [nil      , nil , nil]
    ]
    game = TicTacToe.player_move(pid, 5)
    assert game.board == [
      [:computer, nil      , nil],
      [nil      , :player1 , nil],
      [nil      , nil      , nil]
    ]
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, :computer, nil],
      [nil      , :player1 , nil],
      [nil      , nil      , nil]
    ]
    game = TicTacToe.player_move(pid, 3)
    assert game.board == [
      [:computer, :computer, :player1],
      [nil      , :player1 , nil     ],
      [nil      , nil      , nil     ]
    ]
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, :computer, :player1],
      [nil      , :player1 , nil     ],
      [:computer, nil      , nil     ]
    ]
    game = TicTacToe.player_move(pid, 4)
    assert game.board == [
      [:computer, :computer, :player1],
      [:player1 , :player1 , nil     ],
      [:computer, nil      , nil     ]
    ]
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, :computer, :player1 ],
      [:player1 , :player1 , :computer],
      [:computer, nil      , nil      ]
    ]
    game = TicTacToe.player_move(pid, 8)
    assert game.board == [
      [:computer, :computer, :player1 ],
      [:player1 , :player1 , :computer],
      [:computer, :player1 , nil      ]
    ]
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, :computer, :player1 ],
      [:player1 , :player1 , :computer],
      [:computer, :player1 , :computer]
    ]
    assert game.winner == :draw
  end

  def play_game(:player1, pid) do
    game = TicTacToe.player_move(pid, 5)
    assert game.board == [
      [nil, nil     , nil],
      [nil, :player1, nil],
      [nil, nil     , nil]
    ]
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, nil     , nil],
      [nil      , :player1, nil],
      [nil      , nil     , nil]
    ]
    game = TicTacToe.player_move(pid, 3)
    assert game.board == [
      [:computer, nil     , :player1],
      [nil      , :player1, nil     ],
      [nil      , nil     , nil     ]
    ]
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, nil     , :player1],
      [nil      , :player1, nil     ],
      [:computer, nil     , nil     ]
    ]
    game = TicTacToe.player_move(pid, 4)
    assert game.board == [
      [:computer, nil     , :player1],
      [:player1  , :player1, nil     ],
      [:computer, nil     , nil     ]
    ]
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, nil     , :player1 ],
      [:player1 , :player1, :computer],
      [:computer, nil     , nil      ]
    ]
    game = TicTacToe.player_move(pid, 2)
    assert game.board == [
      [:computer, :player1, :player1 ],
      [:player1 , :player1, :computer],
      [:computer, nil     , nil      ]
    ]
    game = TicTacToe.computer_move(pid)
    assert game.board == [
      [:computer, :player1 , :player1 ],
      [:player1 , :player1 , :computer],
      [:computer, :computer, nil      ]
    ]
    game = TicTacToe.player_move(pid, 9)
    assert game.board == [
      [:computer, :player1 , :player1 ],
      [:player1 , :player1 , :computer],
      [:computer, :computer, :player1 ]
    ]
    assert game.winner == :draw
  end
end
