defmodule Bread.Recipes.Starter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "starters" do
    field :name, :string
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(starter, attrs) do
    starter
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
