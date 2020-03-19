defmodule Bread.Bakes.Bake do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bread.Recipes.Recipe

  schema "bakes" do
    field :ambient_humidity, :float
    field :ambient_temp, :float
    field :bake_temp, :integer
    field :baked_on, :date
    field :dough_amount, :integer
    field :loaf_type, :string
    field :notes, :string
    field :num_loaves, :integer
    field :rating, :integer
    field :status, :string
    belongs_to :recipe, Recipe

    timestamps()
  end

  @doc false
  def changeset(bake, attrs) do
    bake
    |> cast(attrs, [:recipe_id, :status, :baked_on, :loaf_type,
                   :num_loaves, :dough_amount, :bake_temp, :ambient_temp,
                   :ambient_humidity, :rating, :notes])
    |> validate_required([:status, :baked_on, :loaf_type, :num_loaves, :dough_amount])
  end
end
