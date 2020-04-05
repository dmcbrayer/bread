defmodule BreadWeb.Pow.Routes do
  use Pow.Phoenix.Routes
  alias BreadWeb.Router.Helpers, as: Routes

  @impl true
  def after_registration_path(conn), do: Routes.recipe_path(conn, :index)

  @impl true
  def after_sign_in_path(conn), do: Routes.recipe_path(conn, :index)
end
