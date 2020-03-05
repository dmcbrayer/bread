defmodule Bread.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Ingredient

  @starters ["none", "pate fermentee", "poolish", "levain"]

  embedded_schema do
    field :name, :string
    field :starter, :string
    embeds_many :ingredients, Ingredient
  end

  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name])
    |> cast_embed(:ingredients, with: &Ingredient.changeset/2)
    |> validate_required([:name])
    |> validate_inclusion(:starter, @starters)
  end

  def starters do
    @starters
  end
end
