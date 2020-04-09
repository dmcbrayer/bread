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
