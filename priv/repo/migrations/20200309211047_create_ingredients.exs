defmodule Bread.Repo.Migrations.CreateIngredients do
  use Ecto.Migration

  def change do
    create table(:ingredients) do
      add :name, :string
      add :amount, :integer
      add :recipe_id, references(:recipes, on_delete: :delete_all)

      timestamps([type: :utc_datetime])
    end

    create index(:ingredients, [:recipe_id])
  end
end
