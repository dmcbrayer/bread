defmodule BreadWeb.BreadLive do
  use Phoenix.LiveView

  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.PageView, "home.html", assigns)
  end
end
