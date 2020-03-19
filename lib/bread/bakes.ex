defmodule Bread.Bakes do
  @moduledoc """
  The Bakes context.
  """

  import Ecto.Query, warn: false
  alias Bread.Repo

  alias Bread.Bakes.Bake

  @doc """
  Returns the list of bakes.

  ## Examples

      iex> list_bakes()
      [%Bake{}, ...]

  """
  def list_bakes do
    Repo.all(Bake)
  end

  @doc """
  Gets a single bake.

  Raises `Ecto.NoResultsError` if the Bake does not exist.

  ## Examples

      iex> get_bake!(123)
      %Bake{}

      iex> get_bake!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bake!(id), do: Repo.get!(Bake, id)

  @doc """
  Creates a bake.

  ## Examples

      iex> create_bake(%{field: value})
      {:ok, %Bake{}}

      iex> create_bake(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bake(attrs \\ %{}) do
    %Bake{}
    |> Bake.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bake.

  ## Examples

      iex> update_bake(bake, %{field: new_value})
      {:ok, %Bake{}}

      iex> update_bake(bake, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bake(%Bake{} = bake, attrs) do
    bake
    |> Bake.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bake.

  ## Examples

      iex> delete_bake(bake)
      {:ok, %Bake{}}

      iex> delete_bake(bake)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bake(%Bake{} = bake) do
    Repo.delete(bake)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bake changes.

  ## Examples

      iex> change_bake(bake)
      %Ecto.Changeset{source: %Bake{}}

  """
  def change_bake(%Bake{} = bake) do
    Bake.changeset(bake, %{})
  end
end
