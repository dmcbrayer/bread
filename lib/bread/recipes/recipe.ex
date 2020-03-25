defmodule Bread.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Users.User
  alias Bread.Recipes.{Ingredient,RecipeStep}

  @starters ["none", "pate fermentee", "poolish", "levain"]
  schema "recipes" do
    field :name, :string
    field :starter, :string
    belongs_to :user, User
    has_many :ingredients, Ingredient, on_delete: :delete_all, on_replace: :delete
    has_many :recipe_steps, RecipeStep, on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :starter, :user_id])
    |> validate_required([:name, :starter])
    |> validate_inclusion(:starter, @starters)
    |> cast_assoc(:ingredients, with: &Ingredient.changeset/2)

    |> cast_assoc(:recipe_steps, with: &RecipeStep.changeset/2)
  end

  def starters do
    @starters
  end
end
