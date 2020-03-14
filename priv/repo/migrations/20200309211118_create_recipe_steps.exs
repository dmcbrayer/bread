defmodule Bread.Repo.Migrations.CreateRecipeSteps do
  use Ecto.Migration

  def change do
    create table(:recipe_steps) do
      add :order, :integer, default: 0
      add :body, :text
      add :recipe_id, references(:recipes, on_delete: :delete_all)

      timestamps([type: :utc_datetime])
    end

    create index(:recipe_steps, [:recipe_id])
  end
end
