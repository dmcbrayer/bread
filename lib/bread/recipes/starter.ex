defmodule Bread.Recipes.Starter do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Users.User
  alias Bread.Recipes.Ingredient

  schema "starters" do
    field :name, :string
    belongs_to :user, User
    has_many :ingredients, Ingredient, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(starter, attrs) do
    starter
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name])
    |> cast_assoc(:ingredients, with: &Ingredient.changeset/2)
  end
end
