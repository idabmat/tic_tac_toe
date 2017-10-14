defmodule TicTacToe.ServerTest do
  use ExUnit.Case
  alias TicTacToe.Server

  test "handle game_state call" do
    current_game = %TicTacToe.Game{
      board: [
        [nil, nil, nil],
        [nil, :player1, nil],
        [nil, nil, nil]
      ],
      current_player: :computer,
      winner: nil
    }
    assert Server.handle_call({ :game_state }, :ok, current_game) == {:reply, current_game, current_game}
  end

  test "handles player_move call" do
    old_game = %TicTacToe.Game{
      board: [
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
      ],
      current_player: :player1,
      winner: nil
    }
    new_game = %TicTacToe.Game{
      board: [
        [nil, nil, nil],
        [nil, :player1, nil],
        [nil, nil, nil]
      ],
      current_player: :computer,
      winner: nil
    }
    assert Server.handle_call({:player_move, 5}, :ok, old_game) == {:reply, new_game, new_game}
  end

  test "handles computer_move call" do
    old_game = %TicTacToe.Game{
      board: [
        [:player1, :computer, nil],
        [:player1, :computer, nil],
        [nil, nil, nil]
      ],
      current_player: :computer,
      winner: nil
    }
    new_game = %TicTacToe.Game{
      board: [
        [:player1, :computer, nil],
        [:player1, :computer, nil],
        [:computer, nil, nil]
      ],
      current_player: :player1,
      winner: nil
    }
    assert Server.handle_call({:computer_move }, :ok, old_game) == {:reply, new_game, new_game}
  end
end
