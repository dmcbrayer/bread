defmodule Bread.BakesTest do
  use Bread.DataCase

  alias Bread.Bakes
  alias Bread.Recipes

  describe "bakes" do
    alias Bread.Bakes.Bake

    @valid_attrs %{ambient_humidity: 120.5, ambient_temp: 120.5, bake_temp: 42, baked_on: ~D[2010-04-17], dough_amount: 42, loaf_type: "some loaf_type", notes: "some notes", num_loaves: 42, rating: 42, status: "some status"}
    @update_attrs %{ambient_humidity: 456.7, ambient_temp: 456.7, bake_temp: 43, baked_on: ~D[2011-05-18], dough_amount: 43, loaf_type: "some updated loaf_type", notes: "some updated notes", num_loaves: 43, rating: 43, status: "some updated status"}
    @invalid_attrs %{ambient_humidity: nil, ambient_temp: nil, bake_temp: nil, baked_on: nil, dough_amount: nil, loaf_type: nil, notes: nil, num_loaves: nil, rating: nil, status: nil}

    def bake_fixture(attrs \\ %{}) do
      {:ok, bake} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Bakes.create_bake()

      bake
    end

    test "list_bakes/0 returns all bakes" do
      bake = bake_fixture()
      assert Bakes.list_bakes() == [bake]
    end

    test "get_bake!/1 returns the bake with given id" do
      bake = bake_fixture()
      assert Bakes.get_bake!(bake.id) == bake
    end

    test "create_bake/1 with valid data creates a bake" do
      assert {:ok, %Bake{} = bake} = Bakes.create_bake(@valid_attrs)
      assert bake.ambient_humidity == 120.5
      assert bake.ambient_temp == 120.5
      assert bake.bake_temp == 42
      assert bake.baked_on == ~D[2010-04-17]
      assert bake.dough_amount == 42
      assert bake.loaf_type == "some loaf_type"
      assert bake.notes == "some notes"
      assert bake.num_loaves == 42
      assert bake.rating == 42
      assert bake.status == "some status"
    end

    test "create_bake/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bakes.create_bake(@invalid_attrs)
    end

    test "update_bake/2 with valid data updates the bake" do
      bake = bake_fixture()
      assert {:ok, %Bake{} = bake} = Bakes.update_bake(bake, @update_attrs)
      assert bake.ambient_humidity == 456.7
      assert bake.ambient_temp == 456.7
      assert bake.bake_temp == 43
      assert bake.baked_on == ~D[2011-05-18]
      assert bake.dough_amount == 43
      assert bake.loaf_type == "some updated loaf_type"
      assert bake.notes == "some updated notes"
      assert bake.num_loaves == 43
      assert bake.rating == 43
      assert bake.status == "some updated status"
    end

    test "update_bake/2 with invalid data returns error changeset" do
      bake = bake_fixture()
      assert {:error, %Ecto.Changeset{}} = Bakes.update_bake(bake, @invalid_attrs)
      assert bake == Bakes.get_bake!(bake.id)
    end

    test "delete_bake/1 deletes the bake" do
      bake = bake_fixture()
      assert {:ok, %Bake{}} = Bakes.delete_bake(bake)
      assert_raise Ecto.NoResultsError, fn -> Bakes.get_bake!(bake.id) end
    end

    test "change_bake/1 returns a bake changeset" do
      bake = bake_fixture()
      assert %Ecto.Changeset{} = Bakes.change_bake(bake)
    end
  end
end
