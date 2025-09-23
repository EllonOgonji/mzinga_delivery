alias MzingaDelivery.Repo
alias MzingaDelivery.Accounts.User

admin_email = "admin@mzinga.com"

case Repo.get_by(User, email: admin_email) do
  nil ->
    %User{}
    |> User.changeset(%{
      name: "System Admin",
      email: admin_email,
      password: "admin123",
      role: "admin"
    })
    |> Repo.insert!()

    IO.puts("Admin user created with email: #{admin_email} and password: admin123")

  _ ->
    IO.puts(" Admin user already exists")
end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MzingaDelivery.Repo.insert!(%MzingaDelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
