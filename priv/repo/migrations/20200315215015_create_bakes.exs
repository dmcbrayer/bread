defmodule Bread.Repo.Migrations.CreateBakes do
  use Ecto.Migration

  def change do
    create table(:bakes) do
      add :status, :string
      add :baked_on, :date
      add :loaf_type, :string
      add :num_loaves, :integer
      add :dough_amount, :integer
      add :bake_temp, :integer
      add :ambient_temp, :float
      add :ambient_humidity, :float
      add :rating, :integer
      add :notes, :text
      add :recipe_id, references(:users, on_delete: :delete_all)

      timestamps([type: :utc_datetime])
    end

    create index(:bakes, [:recipe_id])
  end
end
