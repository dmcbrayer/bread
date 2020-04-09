defmodule BreadWeb.AnalyticsChannel do
  use BreadWeb, :channel
  alias Analytics.{PageView, UserTracker, RegistryHelper}

  def join("analytics:users", %{"path" => path, "sessionId" => session_id}, socket) do
    user_id = socket.assigns.user_id
    page_view = PageView.new(user_id, session_id, path)
    registry_key = PageView.registry_key(page_view)

    ref =
      case RegistryHelper.get(registry_key) do
        [{pid, _}] ->
          UserTracker.add_page_view(pid, page_view)
          pid
        [] ->
          {:ok, pid} = start_tracker(page_view)
          pid
      end

    schedule_tick()

    {:ok, assign(socket, :tracker_ref, ref)}
  end

  def handle_info(:tick, %{assigns: %{tracker_ref: ref}} = socket) do
    UserTracker.tick(ref)
    schedule_tick()

    {:noreply, socket}
  end

  defp schedule_tick(timeout \\ 1000) do
    Process.send_after(self(), :tick, timeout)
  end

  defp start_tracker(%PageView{} = pv) do
    DynamicSupervisor.start_child(Analytics.DynamicSupervisor, {UserTracker, pv})
  end
end
