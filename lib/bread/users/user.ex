defmodule Bread.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  use Pow.Ecto.Schema

  schema "users" do
    field :name, :string
    field :is_admin, :boolean, default: false
    pow_user_fields()

    timestamps()
  end

  def changeset(schema, attrs) do
    schema
    |> pow_changeset(attrs)
    |> cast(attrs, [:name, :is_admin])
  end
end
