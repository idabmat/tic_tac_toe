defmodule TicTacToe.Server do
  use GenServer
  alias TicTacToe.Game

  def start_link(), do: start_link(:ok)
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    { :ok, Game.new() }
  end

  def handle_call({ :player_move, position }, _from, game) do
    game = Game.player_move(game, position)
    { :reply, game, game }
  end

  def handle_call({ :computer_move }, _from, game) do
    game = Game.computer_move(game)
    { :reply, game, game }
  end
end
