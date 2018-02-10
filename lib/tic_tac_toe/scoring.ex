defmodule TicTacToe.Scoring do
  alias TicTacToe.Board

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

  def winner(%{game_mode: :misere, board: board}) do
    case winner(%{game_mode: :original, board: board}) do
      :computer -> :player1
      :player1 -> :computer
      other_result -> other_result
    end
  end

  defp announce_winner(false, _), do: nil
  defp announce_winner(_game_is_over, :computer), do: :player1
  defp announce_winner(_game_is_over, :player1), do: :computer

  defp winner?(triplets, player) do
    Enum.any?(triplets, fn x ->
      Enum.all?(x, fn y ->
        y == player
      end)
    end)
  end

  defp draw?(triplets) do
    Enum.all?(triplets, &Enum.all?/1)
  end
end
