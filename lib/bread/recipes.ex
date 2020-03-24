defmodule Bread.Recipes do
  @moduledoc """
  The Recipes context.
  """

  import Ecto.Query, warn: false
  alias Bread.Repo

  alias Bread.Recipes.Recipe
  alias Bread.Recipes.RecipeQueries

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    Recipe
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def list_user_recipes(user) do
    Recipe
    |> RecipeQueries.by_user(user)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!(123)
      %Recipe{}

      iex> get_recipe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(id) do
    Repo.get!(Recipe, id)
    |> Repo.preload([:ingredients, :recipe_steps])
  end

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{source: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe, attrs \\ %{}) do
    Recipe.changeset(recipe, attrs)
  end

  alias Bread.Recipes.Ingredient

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients do
    Repo.all(Ingredient)
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient!(id), do: Repo.get!(Ingredient, id)

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient) do
    Repo.delete(ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{source: %Ingredient{}}

  """
  def change_ingredient(%Ingredient{} = ingredient) do
    Ingredient.changeset(ingredient, %{})
  end

  alias Bread.Recipes.RecipeStep

  @doc """
  Returns the list of recipe_steps.

  ## Examples

      iex> list_recipe_steps()
      [%RecipeStep{}, ...]

  """
  def list_recipe_steps do
    Repo.all(RecipeStep)
  end

  @doc """
  Gets a single recipe_step.

  Raises `Ecto.NoResultsError` if the Recipe step does not exist.

  ## Examples

      iex> get_recipe_step!(123)
      %RecipeStep{}

      iex> get_recipe_step!(456)
      ** (Ecto.NoResultsError)

  """
  def get_recipe_step!(id), do: Repo.get!(RecipeStep, id)

  @doc """
  Creates a recipe_step.

  ## Examples

      iex> create_recipe_step(%{field: value})
      {:ok, %RecipeStep{}}

      iex> create_recipe_step(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe_step(attrs \\ %{}) do
    %RecipeStep{}
    |> RecipeStep.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe_step.

  ## Examples

      iex> update_recipe_step(recipe_step, %{field: new_value})
      {:ok, %RecipeStep{}}

      iex> update_recipe_step(recipe_step, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe_step(%RecipeStep{} = recipe_step, attrs) do
    recipe_step
    |> RecipeStep.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a recipe_step.

  ## Examples

      iex> delete_recipe_step(recipe_step)
      {:ok, %RecipeStep{}}

      iex> delete_recipe_step(recipe_step)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe_step(%RecipeStep{} = recipe_step) do
    Repo.delete(recipe_step)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe_step changes.

  ## Examples

      iex> change_recipe_step(recipe_step)
      %Ecto.Changeset{source: %RecipeStep{}}

  """
  def change_recipe_step(%RecipeStep{} = recipe_step) do
    RecipeStep.changeset(recipe_step, %{})
  end
end
