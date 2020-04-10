defmodule BreadWeb.DashboardController do
  use BreadWeb, :controller

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
