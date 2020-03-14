defmodule Bread.RecipesTest do
  use Bread.DataCase

  alias Bread.Recipes

  describe "recipes" do
    alias Bread.Recipes.Recipe

    @valid_attrs %{name: "some name", starter: "some starter"}
    @update_attrs %{name: "some updated name", starter: "some updated starter"}
    @invalid_attrs %{name: nil, starter: nil}

    def recipe_fixture(attrs \\ %{}) do
      {:ok, recipe} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_recipe()

      recipe
    end

    test "list_recipes/0 returns all recipes" do
      recipe = recipe_fixture()
      assert Recipes.list_recipes() == [recipe]
    end

    test "get_recipe!/1 returns the recipe with given id" do
      recipe = recipe_fixture()
      assert Recipes.get_recipe!(recipe.id) == recipe
    end

    test "create_recipe/1 with valid data creates a recipe" do
      assert {:ok, %Recipe{} = recipe} = Recipes.create_recipe(@valid_attrs)
      assert recipe.name == "some name"
      assert recipe.starter == "some starter"
    end

    test "create_recipe/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe(@invalid_attrs)
    end

    test "update_recipe/2 with valid data updates the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{} = recipe} = Recipes.update_recipe(recipe, @update_attrs)
      assert recipe.name == "some updated name"
      assert recipe.starter == "some updated starter"
    end

    test "update_recipe/2 with invalid data returns error changeset" do
      recipe = recipe_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe(recipe, @invalid_attrs)
      assert recipe == Recipes.get_recipe!(recipe.id)
    end

    test "delete_recipe/1 deletes the recipe" do
      recipe = recipe_fixture()
      assert {:ok, %Recipe{}} = Recipes.delete_recipe(recipe)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe!(recipe.id) end
    end

    test "change_recipe/1 returns a recipe changeset" do
      recipe = recipe_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe(recipe)
    end
  end

  describe "ingredients" do
    alias Bread.Recipes.Ingredient

    @valid_attrs %{amount: 42, name: "some name"}
    @update_attrs %{amount: 43, name: "some updated name"}
    @invalid_attrs %{amount: nil, name: nil}

    def ingredient_fixture(attrs \\ %{}) do
      {:ok, ingredient} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_ingredient()

      ingredient
    end

    test "list_ingredients/0 returns all ingredients" do
      ingredient = ingredient_fixture()
      assert Recipes.list_ingredients() == [ingredient]
    end

    test "get_ingredient!/1 returns the ingredient with given id" do
      ingredient = ingredient_fixture()
      assert Recipes.get_ingredient!(ingredient.id) == ingredient
    end

    test "create_ingredient/1 with valid data creates a ingredient" do
      assert {:ok, %Ingredient{} = ingredient} = Recipes.create_ingredient(@valid_attrs)
      assert ingredient.amount == 42
      assert ingredient.name == "some name"
    end

    test "create_ingredient/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_ingredient(@invalid_attrs)
    end

    test "update_ingredient/2 with valid data updates the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{} = ingredient} = Recipes.update_ingredient(ingredient, @update_attrs)
      assert ingredient.amount == 43
      assert ingredient.name == "some updated name"
    end

    test "update_ingredient/2 with invalid data returns error changeset" do
      ingredient = ingredient_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_ingredient(ingredient, @invalid_attrs)
      assert ingredient == Recipes.get_ingredient!(ingredient.id)
    end

    test "delete_ingredient/1 deletes the ingredient" do
      ingredient = ingredient_fixture()
      assert {:ok, %Ingredient{}} = Recipes.delete_ingredient(ingredient)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_ingredient!(ingredient.id) end
    end

    test "change_ingredient/1 returns a ingredient changeset" do
      ingredient = ingredient_fixture()
      assert %Ecto.Changeset{} = Recipes.change_ingredient(ingredient)
    end
  end

  describe "recipe_steps" do
    alias Bread.Recipes.RecipeStep

    @valid_attrs %{body: "some body", order: 42}
    @update_attrs %{body: "some updated body", order: 43}
    @invalid_attrs %{body: nil, order: nil}

    def recipe_step_fixture(attrs \\ %{}) do
      {:ok, recipe_step} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipes.create_recipe_step()

      recipe_step
    end

    test "list_recipe_steps/0 returns all recipe_steps" do
      recipe_step = recipe_step_fixture()
      assert Recipes.list_recipe_steps() == [recipe_step]
    end

    test "get_recipe_step!/1 returns the recipe_step with given id" do
      recipe_step = recipe_step_fixture()
      assert Recipes.get_recipe_step!(recipe_step.id) == recipe_step
    end

    test "create_recipe_step/1 with valid data creates a recipe_step" do
      assert {:ok, %RecipeStep{} = recipe_step} = Recipes.create_recipe_step(@valid_attrs)
      assert recipe_step.body == "some body"
      assert recipe_step.order == 42
    end

    test "create_recipe_step/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipes.create_recipe_step(@invalid_attrs)
    end

    test "update_recipe_step/2 with valid data updates the recipe_step" do
      recipe_step = recipe_step_fixture()
      assert {:ok, %RecipeStep{} = recipe_step} = Recipes.update_recipe_step(recipe_step, @update_attrs)
      assert recipe_step.body == "some updated body"
      assert recipe_step.order == 43
    end

    test "update_recipe_step/2 with invalid data returns error changeset" do
      recipe_step = recipe_step_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipes.update_recipe_step(recipe_step, @invalid_attrs)
      assert recipe_step == Recipes.get_recipe_step!(recipe_step.id)
    end

    test "delete_recipe_step/1 deletes the recipe_step" do
      recipe_step = recipe_step_fixture()
      assert {:ok, %RecipeStep{}} = Recipes.delete_recipe_step(recipe_step)
      assert_raise Ecto.NoResultsError, fn -> Recipes.get_recipe_step!(recipe_step.id) end
    end

    test "change_recipe_step/1 returns a recipe_step changeset" do
      recipe_step = recipe_step_fixture()
      assert %Ecto.Changeset{} = Recipes.change_recipe_step(recipe_step)
    end
  end
end
