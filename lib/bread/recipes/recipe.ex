defmodule Bread.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Users.User
  alias Bread.Recipes.{Ingredient,RecipeStep}

  schema "recipes" do
    field :name, :string
    field :starter, :string
    belongs_to :user, User
    has_many :ingredients, Ingredient, on_delete: :delete_all
    has_many :recipe_steps, RecipeStep, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :starter, :user_id])
    |> validate_required([:name, :starter])
  end
end
