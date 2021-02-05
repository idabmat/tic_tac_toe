defmodule TicTacToe.Game do
  @moduledoc """
  Functions to modify the game state.
  """

  alias TicTacToe.Ai
  alias TicTacToe.Board
  alias TicTacToe.Scoring

  defstruct(
    board: Board.new(),
    winner: nil,
    current_player: nil,
    game_mode: :original
  )

  @type t :: %__MODULE__{
    board: Board.t(),
    winner: Scoring.t(),
    current_player: nil | Board.player(),
    game_mode: mode()
  }

  @type mode :: :original | :notakto | :misere

  @spec new(mode()) :: t()
  def new(game_mode \\ :original) do
    %TicTacToe.Game{current_player: Enum.random([:player1, :computer]), game_mode: game_mode}
  end

  @spec score(t()) :: t()
  def score(game) do
    winner = Scoring.winner(game)
    update_winner(game, winner)
  end

  @spec player_move(t(), Board.position()) :: t()
  def player_move(game, position),
    do: make_move(game, :player1, position, game.current_player == :player1)

  @spec computer_move(t()) :: t()
  def computer_move(game) do
    position = Ai.choose_next_position(game)
    computer_move(game, position)
  end

  @spec computer_move(t(), Board.position()) :: t()
  def computer_move(game, position),
    do: make_move(game, :computer, position, game.current_player == :computer)

  @spec over?(t()) :: boolean()
  def over?(%{winner: nil}), do: false
  def over?(_), do: true

  @spec make_move(t(), Board.player(), Board.position(), boolean()) :: t()
  defp make_move(game, _, _, false), do: game

  defp make_move(game = %{board: board, winner: nil}, player, position, _player_can_move) do
    new_board = board |> Board.receive_move(player, position)
    update_board(game, new_board) |> score
  end

  defp make_move(game, _, _, _), do: game

  @spec update_winner(t(), Scoring.t()) :: t()
  defp update_winner(game, winner) do
    %{game | winner: winner}
  end

  @spec update_board(t(), Board.t()) :: t()
  defp update_board(game = %{board: board}, new_board) do
    valid_move = board != new_board
    update_board(game, new_board, valid_move)
  end

  @spec update_board(t(), Board.t(), boolean()) :: t()
  defp update_board(game, _, false), do: game

  defp update_board(game = %{current_player: :player1}, new_board, _valid_move) do
    %{game | board: new_board, current_player: :computer}
  end

  defp update_board(game = %{current_player: :computer}, new_board, _valid_move) do
    %{game | board: new_board, current_player: :player1}
  end
end
