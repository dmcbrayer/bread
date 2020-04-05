defmodule BreadWeb.RoomChannel do
  use BreadWeb, :channel

  def join("room:" <> room_id, %{"path" => path}, socket) do
    Bread.Tracker.start_link(%{path: path, user_id: socket.assigns.user_id})
    {:ok, assign(socket, :room_id, String.to_integer(room_id))}
  end
end
