defmodule BreadWeb.BreadLive do
  use Phoenix.LiveView
  alias Bread.{Recipe,Ingredient}

  def mount(_session, socket) do
    changeset = Recipe.changeset(%Recipe{}, %{ingredients: [%{}]})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    Phoenix.View.render(BreadWeb.PageView, "home.html", assigns)
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
    IO.puts("Add Ingredient")
    starting_changeset = socket.assigns.changeset

    changeset =
      starting_changeset
      |> Ecto.Changeset.change(%{ingredients: starting_changeset.changes.ingredients ++ [%Ingredient{}]})

    {:noreply, assign(socket, changeset: changeset)}
  end

  # @TODO handle it if the user tries to remove the last ingredient
  def handle_event("remove_ingredient", %{"idx" => idx}, socket) do
    IO.puts("Remove ingredient")

    starting_changeset = socket.assigns.changeset
    ingredients = List.delete_at(starting_changeset.changes.ingredients, String.to_integer(idx))

    changeset =
      starting_changeset
      |> Ecto.Changeset.change(%{ingredients: ingredients})

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", params, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end
end
