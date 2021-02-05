defmodule TicTacToe do
  @moduledoc """
  Public functions for playing the game.
  """

  alias TicTacToe.Board
  alias TicTacToe.Game

  @spec new_game(Game.mode()) :: Game.t()
  def new_game(game_mode \\ :original) do
    Game.new(game_mode)
  end

  @spec player_move(Game.t(), Board.position()) :: Game.t()
  def player_move(game, position) do
    Game.player_move(game, position)
  end

  @spec computer_move(Game.t()) :: Game.t()
  def computer_move(game) do
    Game.computer_move(game)
  end
end
