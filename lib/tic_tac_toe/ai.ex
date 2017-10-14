defmodule TicTacToe.Ai do
  alias TicTacToe.Board
  alias TicTacToe.Game

  def playable_positions(%{board: board}) do
    board
    |> Board.empty_cells
    |> Enum.map(&(Board.position_from_indexes(&1, board)))
  end

  def simulate_move(game = %{current_player: :player1}, position) do
    Game.player_move(game, position)
  end
  def simulate_move(game = %{current_player: :computer}, position) do
    Game.computer_move(game, position)
  end

  def score(%{winner: :computer}), do:  1
  def score(%{winner: :player1 }), do: -1
  def score(%{winner: :draw    }), do:  0
  def score(game = %{current_player: :computer}) do
    game
    |> playable_positions
    |> Enum.map(&(score(simulate_move(game, &1))))
    |> Enum.max
  end
  def score(game = %{current_player: :player1}) do
    game
    |> playable_positions
    |> Enum.map(&(score(simulate_move(game, &1))))
    |> Enum.min
  end

  def choose_next_position(%{board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]}), do: 1
  def choose_next_position(game) do
    game
    |> playable_positions
    |> Enum.map(&([&1, score(simulate_move(game, &1))]))
    |> Enum.max_by(&(Enum.at(&1, 1)))
    |> Enum.at(0)
  end
end
