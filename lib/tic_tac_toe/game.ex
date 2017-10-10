defmodule TicTacToe.Game do
  alias TicTacToe.Ai
  alias TicTacToe.Board

  defstruct(
    board: Board.new(),
    winner: nil,
    current_player: nil
  )

  def new() do
    %TicTacToe.Game{current_player: Enum.random([:player1, :computer])}
  end

  def score(game = %{board: board}) do
    winner = board
             |> Board.triplets
             |> winner?
    update_winner(game, winner)
  end

  def player_move(game, position), do: make_move(game, :player1, position)
  def computer_move(game) do
    position = Ai.choose_next_position(game)
    computer_move(game, position)
  end
  def computer_move(game, position), do: make_move(game, :computer, position)

  def over?(%{winner: nil}), do: false
  def over?(_),              do: true

  defp make_move(game = %{board: board}, player, position) do
    new_board = board |> Board.receive_move(player, position)
    update_board(game, new_board) |> score
  end

  defp winner?(triplets) do
    cond do
      winner?(triplets, :computer) -> :computer
      winner?(triplets, :player1)  -> :player1
      draw?(triplets)               -> :draw
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

  defp draw?(triplets) do
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
