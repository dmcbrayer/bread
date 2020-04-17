defmodule Bread.Repo.Migrations.AddTypeToIngredients do
  use Ecto.Migration

  def change do
    alter table(:ingredients) do
      add :type, :string
    end
  end
end
