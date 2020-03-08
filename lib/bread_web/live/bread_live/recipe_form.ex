defmodule BreadWeb.BreadLive.RecipeForm do
  use Phoenix.LiveView
  alias BreadWeb.Router.Helpers, as: Routes
  alias Bread.{Recipe,Ingredient}

  def mount(_params, _session, socket) do
    changeset =
      Recipe.changeset(%Recipe{}, %{ingredients: [%{}], steps: [%{}]})

    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.RecipeView, "form.html", assigns)
  end

  def handle_event("validate", %{"recipe" => params}, socket) do
    IO.inspect(params)

    changeset =
      %Recipe{}
      |> Recipe.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
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

  def handle_event("save", %{"recipe" => params}, socket) do
    IO.inspect(params)

    case Enum.random([true, false]) do
      true ->
        {:noreply,
          socket
          |> put_flash(:info, "Recipe successfully saved")
          |> redirect(to: Routes.page_path(BreadWeb.Endpoint, :index))
        }
      false ->
        {:noreply, socket}
    end
  end

  def handle_event("add_step", _params, socket) do
    starting_cs = socket.assigns.changeset
    steps = starting_cs.changes.steps ++ [%Recipe.RecipeStep{}]

    changeset =
      starting_cs
      |> update_steps(steps)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove_step", %{"idx" => idx}, socket) do
    starting_cs = socket.assigns.changeset
    steps =
      case Enum.count(starting_cs.changes.steps) do
        1 -> starting_cs.changes.steps
        _ -> List.delete_at(starting_cs.changes.steps, String.to_integer(idx))
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
    |> Ecto.Changeset.change(%{steps: steps})
  end
end
