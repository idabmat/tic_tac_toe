defmodule TicTacToe.Scoring do
  @moduledoc """
  Functions for finding who won the game.
  """

  alias TicTacToe.Board
  alias TicTacToe.Game

  @type t() :: nil | Board.player() | :draw

  @spec winner(Game.t()) :: t()
  def winner(%{game_mode: :original, board: board}) do
    triplets = Board.triplets(board)

    cond do
      winner?(triplets, :computer) -> :computer
      winner?(triplets, :player1) -> :player1
      draw?(triplets) -> :draw
      true -> nil
    end
  end

  def winner(%{game_mode: :notakto, board: board, current_player: current_player}) do
    board
    |> Board.triplets()
    |> Enum.any?(&Enum.all?/1)
    |> announce_winner(current_player)
  end

  def winner(game = %{game_mode: :misere}) do
    case winner(%{game | game_mode: :original}) do
      :computer -> :player1
      :player1 -> :computer
      other_result -> other_result
    end
  end

  @spec announce_winner(boolean(), Board.player()) :: nil | Board.player()
  defp announce_winner(false, _), do: nil
  defp announce_winner(_game_is_over, :computer), do: :player1
  defp announce_winner(_game_is_over, :player1), do: :computer

  @spec winner?([Board.triplet()], Board.player()) :: boolean()
  defp winner?(triplets, player) do
    Enum.any?(triplets, fn x ->
      Enum.all?(x, fn y ->
        y == player
      end)
    end)
  end

  @spec draw?([Board.triplet()]) :: boolean()
  defp draw?(triplets) do
    Enum.all?(triplets, &Enum.all?/1)
  end
end
