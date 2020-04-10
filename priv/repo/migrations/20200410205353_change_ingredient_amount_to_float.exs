defmodule Bread.Repo.Migrations.ChangeIngredientAmountToFloat do
  use Ecto.Migration

  def change do
    alter table("ingredients") do
      modify(:amount, :float, from: :integer)
    end
  end
end
