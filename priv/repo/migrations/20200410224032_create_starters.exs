defmodule Bread.Repo.Migrations.CreateStarters do
  use Ecto.Migration

  def change do
    create table(:starters) do
      add :name, :string
      add :user, references(:users, on_delete: :delete_all)

      timestamps()
    end

    alter table(:ingredients) do
      add :starter, references(:starters, on_delete: :delete_all)
    end

    create index(:starters, [:user])
    create index(:ingredients, [:starter])
  end
end
