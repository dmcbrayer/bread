defmodule Bread.Users do
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
end

