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
    plug :put_live_layout, {BreadWeb.LayoutView, "app.html"}
    plug :put_user_token
    plug :put_session_id
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

    scope "/" do
      pipe_through :protected

      live "/form", BreadLive.RecipeForm, session: {__MODULE__, :with_current_user, []}

      resources "/recipes", RecipeController, except: [:new, :create, :edit, :update]

      live "/recipes/:id/edit", BreadLive.EditRecipeForm, session: {__MODULE__, :with_current_user, []}
      # live "/recipes/:id/bake", BreadLive.BakeRecipe, session: {__MODULE__, :with_current_user, []}
    end
  end

  scope "/" do
    pipe_through :browser
    pow_routes()
  end

  # Other scopes may use custom stacks.
  # scope "/api", BreadWeb do
  #   pipe_through :api
  # end

  def with_current_user(conn) do
    %{"current_user" => Pow.Plug.current_user(conn)}
  end

  defp put_user_token(conn, _) do
    if current_user = Pow.Plug.current_user(conn) do
      salt = BreadWeb.Endpoint.config(:secret_key_base)
      token = Phoenix.Token.sign(conn, salt, current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

  @max_age 600
  defp put_session_id(conn, _) do
    if session_id = conn.req_cookies["_bread_analytics_session_id"] do
      conn
      |> put_resp_cookie("_bread_analytics_session_id", session_id, signed: true, max_age: @max_age)
    else
      session_id = SecureRandom.urlsafe_base64()
      conn
      |> put_resp_cookie("_bread_analytics_session_id", session_id, signed: true, max_age: @max_age)
    end
  end
end
