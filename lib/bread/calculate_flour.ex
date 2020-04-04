defmodule Bread.CalculateFlour do
  # https://www.bbga.org/files/BakersPercent-Healea.pdf
  def total_flour(recipe, amount) do
    flour_proportion =
      recipe.ingredients
      |> Enum.map(fn i -> i.amount end)
      |> Enum.sum()
      |> Kernel./(100)

    round(amount / flour_proportion)
  end

  def adjusted_ingredients(total_flour, ingredients) do
    Enum.map(ingredients, fn i ->
      new_amount = (i.amount / 100) * total_flour
      Map.replace!(i, :amount, round(new_amount))
    end)
  end
end
