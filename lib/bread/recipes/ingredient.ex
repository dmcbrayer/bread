defmodule Bread.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Recipes.Recipe

  schema "ingredients" do
    field :amount, :float
    field :name, :string
    belongs_to :recipe, Recipe

    timestamps()
  end

  @doc false
  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name, :amount])
    |> validate_required([:name, :amount])
  end
end
