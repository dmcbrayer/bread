defmodule Bread.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Ingredient

  embedded_schema do
    field :name, :string
    embeds_many :ingredients, Ingredient
  end

  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name])
    |> cast_embed(:ingredients, with: &Ingredient.changeset/2)
    |> validate_required([:name])
  end
end
