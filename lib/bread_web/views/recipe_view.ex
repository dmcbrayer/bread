defmodule BreadWeb.RecipeView do
  use BreadWeb, :view

  alias Bread.Recipes.Recipe

  def bread_starters do
    Recipe.starters()
  end
end
