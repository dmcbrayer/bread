defmodule BreadWeb.Router do
  use BreadWeb, :router
  use Pow.Phoenix.Router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  scope "/", BreadWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/form", BreadLive.RecipeForm
  end

  scope "/" do
    pipe_through :browser
    pow_routes()
  end

  # Other scopes may use custom stacks.
  # scope "/api", BreadWeb do
  #   pipe_through :api
  # end
end
