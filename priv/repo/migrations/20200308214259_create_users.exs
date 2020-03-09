defmodule Bread.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false
      add :password_hash, :string
      add :is_admin, :boolean, default: false

      timestamps([type: :utc_datetime])
    end

    create unique_index(:users, [:email])
  end
end
