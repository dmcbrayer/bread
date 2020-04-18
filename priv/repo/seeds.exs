# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bread.Repo.insert!(%Bread.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Create Users
# ============
users = [
  %{
    email: "user@mail.com", password: "qwer1234",
    password_confirmation: "qwer1234", name: "Test User"
  },
  %{
    email: "user2@mail.com", password: "qwer1234",
    password_confirmation: "qwer1234", name: "Test User 2"
  },
  %{
    email: "admin@mail.com", password: "qwer1234",
    password_confirmation: "qwer1234", name: "Test Admin",
    is_admin: true
  }
]

Enum.each(users, &Bread.Users.create(&1))

# Create Recipes
# ==============
recipes = [
  %{
    name: "Breaducation White Sandwich Bread",
    starter: "none",
    user_id: 3,
    ingredients: [
      %{amount: 100, name: "Bread Flour"},
      %{amount: 63, name: "Water"},
      %{amount: 4, name: "Honey"},
      %{amount: 6, name: "Oil"},
      %{amount: 2, name: "Salt"},
      %{amount: 2, name: "Yeast"}
    ],
    recipe_steps: [
      %{body: "Make the bread", order: 0}
    ]
  }
]

Enum.each(recipes, &Bread.Recipes.create_recipe(&1))

# Create Starters
# ===============
starters = [
  %{
    name: "Poolish",
    user_id: 3,
    ingredients: [
      %{amount: 100, name: "Flour", type: "flour"},
      %{amount: 100, name: "Water", type: "water"},
      %{amount: 0.1, name: "Instant Dry Yeast", type: "yeast"}
    ]
  },
  %{
    name: "Pate Fermentee",
    user_id: 3,
    ingredients: [
      %{amount: 100, name: "Flour", type: "flour"},
      %{amount: 66.67, name: "Water", type: "water"},
      %{amount: 0.67, name: "Instant Dry Yeast", type: "yeast"},
      %{amount: 2, name: "Salt", type: "other"}
    ]
  }
]

Enum.each(starters, &Bread.Recipes.create_starter(&1))
