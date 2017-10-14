defmodule TicTacToe.Server do
  use GenServer
  alias TicTacToe.Game

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(_) do
    { :ok, Game.new() }
  end

  def handle_call({ :game_state }, _from, game) do
    { :reply, game, game }
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
