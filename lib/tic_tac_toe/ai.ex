defmodule TicTacToe.Ai do
  @moduledoc """
  Function for finding the best next move using MinMax.
  """

  alias TicTacToe.Board
  alias TicTacToe.Game

  @typep computer_score :: -1 | 0 | 1

  @spec playable_positions(Game.t()) :: [Board.position()]
  def playable_positions(%{board: board}) do
    board
    |> Board.empty_cells()
    |> Enum.map(&Board.position_from_indexes(&1, board))
  end

  @spec simulate_move(Game.t(), Board.position()) :: Game.t()
  def simulate_move(game = %{current_player: :player1}, position) do
    Game.player_move(game, position)
  end

  def simulate_move(game = %{current_player: :computer}, position) do
    Game.computer_move(game, position)
  end

  @spec score(Game.t()) :: computer_score()
  def score(%{winner: :computer}), do: 1
  def score(%{winner: :player1}), do: -1
  def score(%{winner: :draw}), do: 0

  def score(game = %{current_player: :computer}) do
    game
    |> playable_positions
    |> Enum.map(&score(simulate_move(game, &1)))
    |> Enum.max()
  end

  def score(game = %{current_player: :player1}) do
    game
    |> playable_positions
    |> Enum.map(&score(simulate_move(game, &1)))
    |> Enum.min()
  end

  @spec choose_next_position(Game.t()) :: Board.position()
  def choose_next_position(%{
        game_mode: :misere,
        board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
      }),
      do: 5

  def choose_next_position(%{board: [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]}), do: 1

  def choose_next_position(game) do
    game
    |> playable_positions
    |> Enum.map(&[&1, score(simulate_move(game, &1))])
    |> Enum.max_by(&Enum.at(&1, 1))
    |> Enum.at(0)
  end
end
