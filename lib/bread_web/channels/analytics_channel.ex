defmodule BreadWeb.AnalyticsChannel do
  use BreadWeb, :channel
  alias Analytics.{PageView, UserTracker}

  def join("analytics:users", %{"path" => path, "sessionId" => session_id}, socket) do
    user_id = socket.assigns.user_id
    page_view = PageView.new(user_id, session_id, path)
    registry_key = PageView.registry_key(page_view)

    ref =
      case Registry.lookup(Analytics.Registry, registry_key) do
        [{pid, _}] ->
          UserTracker.add_page_view(pid, page_view)
          pid
        [] ->
          {:ok, pid} = start_tracker(page_view)
          pid
      end

    socket =
      socket
      |> assign(:tracker_ref, ref)

    Process.send_after(self(), :tick, 1000)

    {:ok, socket}
  end

  def handle_info(:tick, %{assigns: %{tracker_ref: ref}} = socket) do
    UserTracker.tick(ref)
    Process.send_after(self(), :tick, 1000)

    {:noreply, socket}
  end

  defp start_tracker(%PageView{} = pv) do
    DynamicSupervisor.start_child(Analytics.DynamicSupervisor, {UserTracker, pv})
  end
end
