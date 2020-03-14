defmodule BreadWeb.PageControllerTest do
  use BreadWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Bread App"
  end
end
