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

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.RecipeView, "form.html", assigns)
  end

  def handle_event("validate", %{"recipe" => params}, %{assigns: %{recipe: recipe }} = socket) do
    changeset =
      recipe
      |> Recipes.change_recipe(params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
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


  def handle_event("add_ingredient", _params, %{assigns: %{changeset: changeset}} = socket) do
    ingredients =
      changeset
      |> Ecto.Changeset.fetch_field!(:ingredients)
      |> Kernel.++([%Ingredient{}])

    changeset =
      changeset
      |> Ecto.Changeset.change(%{ingredients: ingredients})

    {:noreply, assign(socket, changeset: changeset)}
  end

  defp maybe_remove_ingredient(ingredients, idx) when length(ingredients) == 1, do: ingredients
  defp maybe_remove_ingredient(ingredients, idx), do: remove_ingredient(ingredients, idx)

  def handle_event("remove_ingredient", %{"idx" => idx}, %{assigns: %{changeset: changeset}} = socket) do
    ingredients =
      changeset
      |> Ecto.Changeset.fetch_field!(:ingredients)
      |> maybe_remove_ingredient(idx)

    recipe = Recipes.get_recipe!(changeset.data.id)
    changeset =
      changeset
      |> Ecto.Changeset.change(%{ingredients: ingredients})
      |> Map.merge(%{data: recipe})

    {:noreply, assign(socket, changeset: changeset, recipe: recipe)}

  end

  def handle_event("add_step", _params, %{assigns: %{changeset: changeset}} = socket) do
    steps =
      changeset
      |> Ecto.Changeset.fetch_field!(:recipe_steps)
      |> Kernel.++([%RecipeStep{}])

    changeset =
      changeset
      |> Ecto.Changeset.change(%{recipe_steps: steps})

    {:noreply, assign(socket, changeset: changeset)}
  end

  defp maybe_remove_step(steps, idx) when length(steps) == 1, do: steps
  defp maybe_remove_step(steps, idx), do: remove_step(steps, idx)

  def handle_event("remove_step", %{"idx" => idx}, %{assigns: %{changeset: changeset}} = socket) do
    steps =
      changeset
      |> Ecto.Changeset.fetch_field!(:recipe_steps)
      |> maybe_remove_step(idx)

    recipe = Recipes.get_recipe!(changeset.data.id)
    changeset =
      changeset
      |> Ecto.Changeset.change(%{recipe_steps: steps})
      |> Map.merge(%{data: recipe})

    {:noreply, assign(socket, changeset: changeset, recipe: recipe)}
  end

  defp maybe_delete_step(%RecipeStep{id: nil}), do: nil
  defp maybe_delete_step(%RecipeStep{} = step), do: Recipes.delete_recipe_step(step)
  defp maybe_delete_step(step), do: nil

  defp remove_step(steps, index) do
    index = String.to_integer(index)

    steps
    |> Enum.at(index)
    |> maybe_delete_step()

    List.delete_at(steps, index)
  end

  defp maybe_delete_ingredient(%Ingredient{id: nil}), do: nil
  defp maybe_delete_ingredient(%Ingredient{} = ingredient), do: Recipes.delete_ingredient(ingredient)
  defp maybe_delete_ingredient(ingredient), do: nil

  defp remove_ingredient(ingredients, index) do
    index = String.to_integer(index)

    ingredients
    |> Enum.at(index)
    |> maybe_delete_ingredient()

    List.delete_at(ingredients, index)
  end
end
