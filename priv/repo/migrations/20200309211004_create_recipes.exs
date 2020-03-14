defmodule Bread.Repo.Migrations.CreateRecipes do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :starter, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps([type: :utc_datetime])
    end

    create index(:recipes, [:user_id])
  end
end
