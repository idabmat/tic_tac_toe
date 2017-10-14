defmodule TicTacToe do
  def new_game() do
    Supervisor.start_child(TicTacToe.Supervisor, [])
  end

  def game_state(game_pid) do
    GenServer.call(game_pid, { :game_state })
  end

  def player_move(game_pid, position) do
    GenServer.call(game_pid, { :player_move, position })
  end

  def computer_move(game_pid) do
    GenServer.call(game_pid, { :computer_move }, 10_000)
  end
end
