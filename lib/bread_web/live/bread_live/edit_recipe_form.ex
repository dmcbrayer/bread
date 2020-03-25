defmodule BreadWeb.BreadLive.EditRecipeForm do
  use Phoenix.LiveView
  alias BreadWeb.Router.Helpers, as: Routes
  alias Bread.Recipes
  alias Bread.Recipes.{Recipe,Ingredient,RecipeStep}

  def mount(%{"id" => recipe_id}, _session, socket) do
    recipe = Recipes.get_recipe!(recipe_id)
    changeset =
      Recipes.change_recipe(recipe)

    socket =
      socket
      |> assign(:changeset, changeset)
      |> assign(:recipe, recipe)

    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.RecipeView, "form.html", assigns)
  end

  def handle_event("validate", %{"recipe" => params}, %{assigns: %{recipe: recipe }} = socket) do
    IO.inspect(params)

    changeset =
      recipe
      |> Recipes.change_recipe(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset, params: params)}
  end

  def handle_event("save", %{"recipe" => params}, %{assigns: %{recipe: recipe}} = socket) do
    case Recipes.update_recipe(recipe, params) do
      {:ok, recipe} ->
        {:noreply,
          socket
          |> put_flash(:info, "Recipe successfully saved")
          |> redirect(to: Routes.page_path(BreadWeb.Endpoint, :index))
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end


  def handle_event("add_ingredient", params, socket) do
    IO.puts("Add Ingredient called")
    starting_changeset = socket.assigns.changeset
    recipe = socket.assigns.recipe

    IO.inspect(params)

    ingredients =
      case Map.has_key?(starting_changeset.changes, :ingredients) do
        true -> starting_changeset.changes.ingredients ++ [%Ingredient{}]
        _ -> recipe.ingredients ++ [%Ingredient{}]
      end

    changeset =
      starting_changeset
      |> Ecto.Changeset.change(%{ingredients: ingredients})

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove_ingredient", %{"idx" => idx}, socket) do
    starting_cs = socket.assigns.changeset
    recipe = socket.assigns.recipe

    ingredients =
      case Map.has_key?(starting_cs.changes, :ingredients) do
        true -> starting_cs.changes.ingredients
        _ -> recipe.ingredients
      end

    new_ingredients =
      case length(ingredients) do
        1 -> ingredients
        _ -> remove_ingredient(ingredients, idx)
      end

    recipe = Recipes.get_recipe!(socket.assigns.recipe.id)
    changeset =
      starting_cs
      |> Ecto.Changeset.change(%{ingredients: new_ingredients})
      |> Map.merge(%{data: recipe})

    {:noreply, assign(socket, changeset: changeset, recipe: recipe)}

  end

  def handle_event("add_step", _params, socket) do
    starting_cs = socket.assigns.changeset
    recipe = socket.assigns.recipe

    steps =
      case Map.has_key?(starting_cs.changes, :recipe_steps) do
        true -> starting_cs.changes.recipe_steps ++ [%RecipeStep{}]
        _ -> recipe.recipe_steps ++ [%RecipeStep{}]
      end

    changeset =
      starting_cs
      |> Ecto.Changeset.change(%{recipe_steps: steps})

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove_step", %{"idx" => idx}, socket) do
    starting_cs = socket.assigns.changeset
    recipe = socket.assigns.recipe

    steps =
      case Map.has_key?(starting_cs.changes, :recipe_steps) do
        true -> starting_cs.changes.recipe_steps
        _ -> recipe.recipe_steps
      end

    new_steps =
      case length(steps) do
        1 -> steps
        _ -> remove_step(steps, idx)
      end

    recipe = Recipes.get_recipe!(socket.assigns.recipe.id)
    changeset =
      starting_cs
      |> Ecto.Changeset.change(%{recipe_steps: new_steps})
      |> Map.merge(%{data: recipe})

    {:noreply, assign(socket, changeset: changeset, recipe: recipe)}
  end

  defp remove_step(steps, index) do
    index = String.to_integer(index)
    step = Enum.at(steps, index)

    case step do
      %RecipeStep{} = recipe_step ->
        Recipes.delete_recipe_step(recipe_step)
      %Ecto.Changeset{} -> nil
    end

    List.delete_at(steps, index)
  end

  defp remove_ingredient(ingredients, index) do
    index = String.to_integer(index)
    ingredient = Enum.at(ingredients, index)

    case ingredient do
      %Ingredient{} = ingredient ->
        Recipes.delete_ingredient(ingredient)
      %Ecto.Changeset{} -> nil
    end

    List.delete_at(ingredients, index)
  end
end
