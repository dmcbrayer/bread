defmodule BreadWeb.RoomChannel do
  use BreadWeb, :channel

  def join("room:" <> room_id, _params, socket) do
    {:ok, assign(socket, :room_id, String.to_integer(room_id))}
  end
end
