defmodule BreadWeb.RoomChannel do
  use BreadWeb, :channel
  alias Analytics.{PageView, UserTracker}

  def join("room:" <> room_id, %{"path" => path, "sessionId" => session_id}, socket) do
    user_id = socket.assigns.user_id
    page_view = PageView.new(user_id, session_id, path)
    registry_key = PageView.registry_key(page_view)

    ref = case Registry.lookup(Analytics.Registry, registry_key) do
      [{ref, _}] -> ref
      [] ->
        {:ok, ref} =
          DynamicSupervisor.start_child(Analytics.DynamicSupervisor, {UserTracker, page_view})
        ref
    end

    socket =
      socket
      |> assign(:room_id, String.to_integer(room_id))
      |> assign(:tracker_ref, ref)

    Process.send_after(self(), :tick, 1000)

    {:ok, socket}
  end

  def handle_info(:tick, %{assigns: %{tracker_ref: ref}} = socket) do
    UserTracker.tick(ref)
    Process.send_after(self(), :tick, 1000)

    {:noreply, socket}
  end

  # Dump the state of the tracking bucket to something
  # more permanent
  def terminate(_reason, %{assigns: %{tracker_ref: ref}}) do
    # state = UserTracker.get_state(ref)
    # IO.puts("Dumping user state to disk...")
    # Task.start(fn -> Bread.Dump.dump(state) end)
  end
end
