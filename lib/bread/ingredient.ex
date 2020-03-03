defmodule Bread.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bread.Recipe

  embedded_schema do
    field :amount, :integer
    field :name, :string
  end

  def changeset(ingredient, attrs) do
    ingredient
    |> cast(attrs, [:amount, :name])
    |> validate_required([:amount, :name])
  end
end
