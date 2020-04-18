defmodule Bread.Repo.Migrations.CreateStarters do
  use Ecto.Migration

  def change do
    create table(:starters) do
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    alter table(:ingredients) do
      add :starter_id, references(:starters, on_delete: :delete_all)
      add :type, :string
    end

    create index(:starters, [:user_id])
    create index(:ingredients, [:starter_id])
  end
end
