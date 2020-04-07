defmodule Bread.UserTracker do
  use GenServer

  def start_link(state) when is_map_key(state, :session_id) do
    GenServer.start_link(__MODULE__,  state, name: via_tuple(state.session_id))
  end

  def init(state) do
    {:ok, state}
  end

  def get_state(tracker) do
    GenServer.call(tracker, :get_state)
  end

  def tick(tracker) do
    GenServer.cast(tracker, :tick)
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:tick, state) do
    new_state =
      state
      |> Map.put(:time, state.time + 1)
      |> Map.put(:ends_at, DateTime.utc_now())

    {:noreply, new_state}
  end

  defp via_tuple(name), do: {:via, Registry, {Tracker.Registry, name}}
end
