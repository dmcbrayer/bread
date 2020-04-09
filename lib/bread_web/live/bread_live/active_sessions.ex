defmodule BreadWeb.BreadLive.ActiveSessions do
  use Phoenix.LiveView

  alias Analytics.{PageView, UserTracker, RegistryHelper}

  def mount(_params, _session, socket) do
    schedule_refresh()
    {:ok, assign(socket, sessions: fetch_sessions())}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.PageView, "active_sessions.html", assigns)
  end

  def handle_info(:refresh, socket) do
    schedule_refresh()
    {:noreply, assign(socket, sessions: fetch_sessions())}
  end

  defp fetch_sessions() do
    RegistryHelper.list_and_get()
    |> Enum.map(fn pid ->
      pid
      |> UserTracker.get_state()
      |> Map.get(:page_views)
      |> hd()
    end)
  end

  defp schedule_refresh() do
    Process.send_after(self(), :refresh, 500)
  end

end
