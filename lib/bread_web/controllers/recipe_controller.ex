defmodule BreadWeb.RecipeController do
  use BreadWeb, :controller

  alias Bread.Recipes

  def index(conn, _params) do
    recipes = Recipes.list_recipes()
    render(conn, "index.html", recipes: recipes)
  end
end
