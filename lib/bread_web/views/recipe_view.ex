defmodule BreadWeb.RecipeView do
  use BreadWeb, :view

  alias Bread.Recipes.Recipe

  def bread_starters do
    Recipe.starters()
  end

  def ordered_recipe_steps(recipe_steps) do
    Enum.sort_by(recipe_steps, &(&1.order))
    |> Enum.with_index()
  end
end
