defmodule BreadWeb.BreadLive.RecipeForm do
  use Phoenix.LiveView
  alias BreadWeb.Router.Helpers, as: Routes
  alias Bread.Recipes
  alias Bread.Recipes.{Recipe,Ingredient,RecipeStep}

  def mount(_params, %{"current_user" => current_user}, socket) do
    changeset =
      Recipes.change_recipe(%Recipe{}, %{ingredients: [%{}], recipe_steps: [%{}]})

    {:ok, assign(socket, changeset: changeset, current_user: current_user)}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.RecipeView, "form.html", assigns)
  end

  def handle_event("validate", %{"recipe" => params}, socket) do
    IO.inspect(params)

    params =
      params
      |> Map.merge(%{"user_id" => socket.assigns.current_user.id})

    changeset =
      %Recipe{}
      |> Recipes.change_recipe(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"recipe" => params}, socket) do
    params =
      params
      |> Map.merge(%{"user_id" => socket.assigns.current_user.id})

    case Recipes.create_recipe(params) do
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


  def handle_event("add_ingredient", _params, socket) do
    starting_changeset = socket.assigns.changeset
    ingredients =
      starting_changeset.changes.ingredients ++ [%Ingredient{}]

    changeset =
      starting_changeset
      |> update_ingredients(ingredients)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove_ingredient", %{"idx" => idx}, socket) do
    starting_changeset = socket.assigns.changeset

    ingredients =
      case Enum.count(starting_changeset.changes.ingredients) do
        1 -> starting_changeset.changes.ingredients
        _ -> List.delete_at(starting_changeset.changes.ingredients, String.to_integer(idx))
      end

    changeset =
      starting_changeset
      |> update_ingredients(ingredients)

    {:noreply, assign(socket, changeset: changeset)}
  end


  def handle_event("add_step", _params, socket) do
    starting_cs = socket.assigns.changeset
    steps = starting_cs.changes.recipe_steps ++ [%RecipeStep{}]

    changeset =
      starting_cs
      |> update_steps(steps)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove_step", %{"idx" => idx}, socket) do
    starting_cs = socket.assigns.changeset
    steps =
      case Enum.count(starting_cs.changes.recipe_steps) do
        1 -> starting_cs.changes.recipe_steps
        _ -> List.delete_at(starting_cs.changes.recipe_steps, String.to_integer(idx))
      end

    changeset =
      starting_cs
      |> update_steps(steps)

    {:noreply, assign(socket, changeset: changeset)}
  end

  defp update_ingredients(changeset, ingredients) do
    changeset
    |> Ecto.Changeset.change(%{ingredients: ingredients})
  end

  defp update_steps(changeset, steps) do
    changeset
    |> Ecto.Changeset.change(%{recipe_steps: steps})
  end
end
