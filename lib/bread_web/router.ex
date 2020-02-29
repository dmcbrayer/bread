defmodule BreadWeb.Router do
  use BreadWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BreadWeb do
    pipe_through :browser

    live "/", BreadLive
    # get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BreadWeb do
  #   pipe_through :api
  # end
end
