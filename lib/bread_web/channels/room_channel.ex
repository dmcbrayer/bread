defmodule BreadWeb.RoomChannel do
  use BreadWeb, :channel

  def join("room:" <> room_id, %{"path" => path}, socket) do
    {:ok, ref} =
      Bread.Tracker.start_link(%{
        path: path,
        user_id: socket.assigns.user_id,
        time: 0
      })

    socket =
      socket
      |> assign(:room_id, String.to_integer(room_id))
      |> assign(:tracker_ref, ref)

    Process.send_after(self(), :tick, 1000)

    {:ok, socket}
  end

  def handle_info(:tick, %{assigns: %{tracker_ref: ref}} = socket) do
    Bread.Tracker.tick(ref)
    Process.send_after(self(), :tick, 1000)

    {:noreply, socket}
  end

  # Dump the state of the tracking bucket to something
  # more permanent
  def terminate(_reason, %{assigns: %{tracker_ref: ref}} = socket) do
    IO.inspect(Bread.Tracker.bucket_state(ref))
  end
end
