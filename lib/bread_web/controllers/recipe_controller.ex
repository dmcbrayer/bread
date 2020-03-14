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

  def delete(conn, %{"id" => recipe_id}) do
    recipe = Recipes.get_recipe!(recipe_id)

    {:ok, _recipe} = Recipes.delete_recipe(recipe)

    conn
    |> put_flash(:info, "Recipe deleted successfully.")
    |> redirect(to: Routes.recipe_path(conn, :index))
  end
end
