defmodule Bread.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Ingredient

  @starters ["none", "pate fermentee", "poolish", "levain"]

  embedded_schema do
    field :name, :string
    field :starter, :string
    embeds_many :ingredients, Ingredient
    embeds_many :steps, RecipeStep do
      field :body
    end
  end

  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name])
    |> cast_embed(:ingredients, with: &Ingredient.changeset/2)
    |> cast_embed(:steps, with: &recipe_step_changeset/2)
    |> validate_required([:name])
    |> validate_inclusion(:starter, @starters)
  end

  def starters do
    @starters
  end

  def recipe_step_changeset(schema, params) do
    schema
    |> cast(params, [:body])
  end
end
