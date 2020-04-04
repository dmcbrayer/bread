defmodule BreadWeb.BreadLive.ScaleRecipe do
  use Phoenix.LiveView
  alias BreadWeb.Router.Helpers, as: Routes
  alias Bread.Recipes
  alias Bread.Recipes.{Recipe,Ingredient}
  alias Bread.CalculateFlour

  def mount(_params, %{"recipe" => recipe}, socket) do
    ingredients =
      recipe.ingredients
      |> Enum.sort_by(&(&1.amount), :desc)
      |> Enum.map(&({&1.amount, &1.name}))

    socket =
      socket
      |> assign(:scaling, false)
      |> assign(:recipe, recipe)
      |> assign(:amount, 1000)
      |> assign(:ingredients, ingredients)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.RecipeView, "scale.html", assigns)
  end

  def handle_event("validate", %{"scale" => %{"amount" => amount}}, socket) do
    recipe = socket.assigns.recipe

    amount =
      case amount do
        "" -> 0
        _ -> String.to_integer(amount)
    end

    ingredients = recalculate_ingredients(recipe, amount)

    {:noreply, assign(socket, amount: amount, ingredients: ingredients)}
  end

  defp recalculate_ingredients(recipe, amount) do
    recipe
    |> CalculateFlour.total_flour(amount)
    |> CalculateFlour.adjusted_ingredients(Enum.sort_by(recipe.ingredients, &(&1.amount), :desc))
    |> Enum.map(&({&1.amount, &1.name}))
  end

  def handle_event("toggle_scaling", _params, socket) do
    %{
      scaling: scaling,
      recipe: recipe,
      ingredients: ingredients,
      amount: amount
    } = socket.assigns

    ingredients =
      cond do
        scaling ->
          recipe.ingredients
          |> Enum.sort_by(&(&1.amount), :desc)
          |> Enum.map(&({&1.amount, &1.name}))

        true ->
          recalculate_ingredients(recipe, amount)
      end

    socket =
      socket
      |> assign(:scaling, !scaling)
      |> assign(:ingredients, ingredients)

    {:noreply, socket}
  end
end

