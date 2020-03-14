defmodule BreadWeb.RecipeController do
  use BreadWeb, :controller

  alias Bread.Recipes

  def index(conn, _params) do
    recipes = Recipes.list_recipes()
    render(conn, "index.html", recipes: recipes)
  end

  def show(conn, %{"id" => recipe_id}) do
    recipe = Recipes.get_recipe!(recipe_id)
    render(conn, "show.html", recipe: recipe)
  end
end
