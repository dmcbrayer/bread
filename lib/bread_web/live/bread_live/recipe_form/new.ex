defmodule BreadWeb.BreadLive.RecipeForm.New do
  use Phoenix.LiveView, layout: {BreadWeb.LayoutView, "live.html"}
  alias BreadWeb.Router.Helpers, as: Routes
  alias Bread.Recipes
  alias Bread.Recipes.{Recipe,Ingredient,RecipeStep}

  @start_ingredients [%{name: "Flour", amount: 100.0, type: "flour"}, %{name: "Water", amount: 0.0, type: "water"}, %{name: "Yeast", amount: 0.0, type: "yeast"}]
  def mount(_params, %{"current_user" => current_user}, socket) do
    changeset =
      Recipes.change_recipe(%Recipe{starter: "none"}, %{ingredients: @start_ingredients, recipe_steps: [%{}]})

    {:ok, assign(socket, changeset: changeset, current_user: current_user)}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.RecipeView, "form.html", assigns)
  end

  def handle_event("validate", %{"recipe" => params}, %{assigns: %{current_user: current_user}} = socket) do
    params =
      params
      |> Map.merge(%{"user_id" => current_user.id})

    changeset =
      %Recipe{}
      |> Recipes.change_recipe(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"recipe" => params}, %{assigns: %{current_user: current_user}} = socket) do
    params =
      params
      |> Map.merge(%{"user_id" => current_user.id})

    case Recipes.create_recipe(params) do
      {:ok, _recipe} ->
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
      |> Kernel.++([%Ingredient{type: "other"}])

    changeset =
      changeset
      |> Ecto.Changeset.change(%{ingredients: ingredients})

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove_ingredient", %{"idx" => idx}, %{assigns: %{changeset: changeset}} = socket) do
    ingredients =
      changeset
      |> Ecto.Changeset.fetch_field!(:ingredients)
      |> maybe_remove_item(String.to_integer(idx))

    changeset =
      changeset
      |> Ecto.Changeset.change(%{ingredients: ingredients})

    {:noreply, assign(socket, changeset: changeset)}
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

  def handle_event("remove_step", %{"idx" => idx}, %{assigns: %{changeset: changeset}} = socket) do
    steps =
      changeset
      |> Ecto.Changeset.fetch_field!(:recipe_steps)
      |> maybe_remove_item(String.to_integer(idx))

    changeset =
      changeset
      |> Ecto.Changeset.change(%{recipe_steps: steps})

    {:noreply, assign(socket, changeset: changeset)}
  end

  defp maybe_remove_item(items, _index) when length(items) == 1, do: items
  defp maybe_remove_item(items, index) do
    List.delete_at(items, index)
  end
end
