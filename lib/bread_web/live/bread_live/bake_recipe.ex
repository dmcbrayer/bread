defmodule BreadWeb.BreadLive.BakeRecipe do
  use Phoenix.LiveView
  alias BreadWeb.Router.Helpers, as: Routes
  alias Bread.Recipes
  alias Bread.Recipes.{Recipe,Ingredient}
  alias Bread.CalculateFlour

  def mount(%{"id" => recipe_id}, %{"current_user" => current_user}, socket) do
    recipe = Recipes.get_recipe!(recipe_id)

    socket =
      socket
      |> assign(:recipe, recipe)
      |> assign(:loaf_type, "baguette")
      |> assign(:amount, "")
      |> assign(:show_table, false)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.RecipeView, "bake.html", assigns)
  end

  def handle_event("validate", %{"bake" => %{"amount" => "", "loaf_type" => loaf_type}}, %{assigns: %{recipe: recipe}} = socket) do
    socket =
      socket
      |> assign(:loaf_type, loaf_type)
      |> assign(:amount, "")
      |> assign(:show_table, false)

    {:noreply, socket}
  end


  def handle_event("validate", %{"bake" => params}, %{assigns: %{recipe: recipe}} = socket) do
    IO.inspect(params)
    %{"loaf_type" => loaf_type, "amount" => amount } = params

    desired_dough =
      Recipe.loaf_types()
      |> Map.get(String.to_atom(loaf_type))
      |> Kernel.*(String.to_integer(amount))

    total_flour = CalculateFlour.total_flour(recipe, desired_dough)
    ingredients = CalculateFlour.adjusted_ingredients(recipe.ingredients, total_flour)

    socket =
      socket
      |> assign(:loaf_type, loaf_type)
      |> assign(:amount, amount)
      |> assign(:show_table, true)
      |> assign(:desired_dough, desired_dough)
      |> assign(:ingredients, ingredients)

    {:noreply, socket}
  end
end
