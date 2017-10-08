defmodule TicTacToe.Game do
  alias TicTacToe.Board

  defstruct(
    board: Board.new(),
    winner: nil,
    current_player: Enum.random([:player1, :computer])
  )

  def new() do
    %TicTacToe.Game{}
  end

  def score(game = %{board: board}) do
    winner = board
             |> Board.triplets
             |> winner?
    update_winner(game, winner)
  end

  def player_move(game, position), do: make_move(game, :player1, position)

  defp make_move(game = %{board: board}, player, position) do
    new_board = board |> Board.receive_move(player, position)
    update_board(game, new_board)
  end

  defp winner?(triplets) do
    cond do
      winner?(triplets, :computer) -> :computer
      winner?(triplets, :player1)  -> :player1
      game_over?(triplets)         -> :draw
      true                         -> nil
    end
  end

  defp winner?(triplets, player) do
    Enum.any?(triplets, fn (x) ->
      Enum.all?(x, fn (y) ->
        y == player
      end)
    end)
  end

  defp game_over?(triplets) do
    Enum.all?(triplets, &Enum.all?/1)
  end

  defp update_winner(game, winner) do
    %{ game | winner: winner }
  end

  defp update_board(game = %{board: board}, new_board) do
    valid_move = board != new_board
    update_board(game, new_board, valid_move)
  end

  defp update_board(game, _, false), do: game
  defp update_board(game = %{current_player: :player1}, new_board, _valid_move) do
    %{ game | board: new_board, current_player: :computer }
  end
  defp update_board(game = %{current_player: :computer}, new_board, _valid_move) do
    %{ game | board: new_board, current_player: :player1 }
  end
end
