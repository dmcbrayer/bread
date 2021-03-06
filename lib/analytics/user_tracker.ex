defmodule Analytics.UserTracker do
  use GenServer,
    restart: :transient

  alias Analytics.PageView

  # kill after 10 minutes
  @kill_after 10 * 60 * 1000

  def start_link(%PageView{} = state) when is_map_key(state, :session_id) do
    GenServer.start_link(__MODULE__,  %{page_views: [state], kill_ref: nil}, name: via_tuple(state))
  end

  def init(state) do
    kill_ref = Process.send_after(self(), :kill, @kill_after)
    {:ok, %{state | kill_ref: kill_ref}}
  end

  def get_state(tracker) do
    GenServer.call(tracker, :get_state)
  end

  def set_idle(tracker) do
    GenServer.cast(tracker, :set_idle)
  end

  def tick(tracker) do
    GenServer.cast(tracker, :postpone_kill)
    GenServer.cast(tracker, :tick)
  end

  def add_page_view(tracker, %PageView{} = pv) do
    GenServer.cast(tracker, :postpone_kill)
    GenServer.cast(tracker, {:add_page_view, pv})
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast(:set_idle, %{page_views: [pv | tail]} = state) do
    page_views = [Map.put(pv, :status, "idle") | tail]

    {:noreply, %{state | page_views: page_views}}
  end

  def handle_cast(:postpone_kill, %{kill_ref: kill_ref} = state) do
    Process.cancel_timer(kill_ref)
    new_kill_ref = Process.send_after(self(), :kill, @kill_after)

    {:noreply, %{state | kill_ref: new_kill_ref}}
  end

  def handle_cast(:tick, %{page_views: [pv | tail]} = state) do
    pv =
      pv
      |> Map.put(:time, pv.time + 1)
      |> Map.put(:ends_at, DateTime.utc_now() |> DateTime.to_iso8601())
      |> Map.put(:status, "active")

    {:noreply, %{state | page_views: [pv | tail]}}
  end

  def handle_cast({:add_page_view, pv}, state) do
    {:noreply, %{state | page_views: [pv | state.page_views]}}
  end

  def handle_info(:kill, state) do
    name = PageView.registry_key(hd(state.page_views))
    path = Path.join("tmp", name)

    IO.puts("Dumping user state to disk....")
    Task.start(fn -> Bread.Dump.dump(state, path) end)

    {:stop, :normal, state}
  end

  defp via_tuple(%PageView{} = pv) do
    name = PageView.registry_key(pv)
    {:via, Registry, {Analytics.Registry, name}}
  end
end
