defmodule Bread.Users do
  use Pow.Ecto.Context,
    repo: Bread.Repo,
    user: Bread.Users.User

  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Bread.Repo

  alias Bread.Users.User

  def list_users do
    User
    |> Repo.all()
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def create(params) do
    pow_create(params)
  end
end

