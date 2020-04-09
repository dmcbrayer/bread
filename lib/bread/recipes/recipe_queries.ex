defmodule Bread.Recipes.RecipeQueries do
  import Ecto.Query, warn: false

  alias Bread.Users.User

  def by_user(query, %User{id: user_id}) do
    query
    |> where(user_id: ^user_id)
  end
end
