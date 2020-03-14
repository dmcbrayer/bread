defmodule Bread.Recipes.RecipeStep do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Recipes.Recipe

  schema "recipe_steps" do
    field :body, :string
    field :order, :integer
    belongs_to :recipe, Recipe

    timestamps()
  end

  @doc false
  def changeset(recipe_step, attrs) do
    recipe_step
    |> cast(attrs, [:order, :body])
    |> validate_required([:order, :body])
  end
end
