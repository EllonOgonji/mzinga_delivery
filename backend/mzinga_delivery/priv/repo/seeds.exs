alias MzingaDelivery.Repo
alias MzingaDelivery.Accounts.User
alias MzingaDelivery.Stores.Store
alias MzingaDelivery.Products.Product
alias MzingaDelivery.Orders.{Order, OrderItem}
alias MzingaDelivery.Payments.Payment
alias MzingaDelivery.Deliveries.Delivery

# --- ADMIN USER ---
admin_email = "admin@mzinga.com"

admin =
  case Repo.get_by(User, email: admin_email) do
    nil ->
      %User{}
      |> User.changeset(%{
        username: "admin",
        email: admin_email,
        password: "admin123",
        role: "admin"
      })
      |> Repo.insert!()
      IO.puts("Admin user created: #{admin_email} / admin123")

    user ->
      IO.puts("Admin already exists: #{admin_email}")
      user
  end

# --- CUSTOMERS ---
user1 =
  case Repo.get_by(User, email: "alice@example.com") do
    nil ->
      %User{}
      |> User.changeset(%{
        username: "alice",
        email: "alice@example.com",
        password: "password123",
        role: "customer"
      })
      |> Repo.insert!()
    user -> user
  end

user2 =
  case Repo.get_by(User, email: "bob@example.com") do
    nil ->
      %User{}
      |> User.changeset(%{
        username: "bob",
        email: "bob@example.com",
        password: "password123",
        role: "customer"
      })
      |> Repo.insert!()
    user -> user
  end

# --- RIDER USER ---
rider =
  case Repo.get_by(User, email: "rider@example.com") do
    nil ->
      %User{}
      |> User.changeset(%{
        username: "riderjoe",
        email: "rider@example.com",
        password: "riderpass",
        role: "rider"
      })
      |> Repo.insert!()
    user -> user
  end

# --- STORES ---
store1 =
  Repo.insert!(%Store{
    name: "Kilimanjaro Liquor",
    address: "Downtown",
    lat: -1.2921,
    lng: 36.8219
  })

store2 =
  Repo.insert!(%Store{
    name: "Safari Wines",
    address: "Westlands",
    lat: -1.2676,
    lng: 36.8111
  })

store3 =
  Repo.insert!(%Store{
    name: "The Clutch",
    address: "Lurambi",
    lat: -1.2340,
    lng: 36.8000
  })

# --- PRODUCTS ---
products = [
  %{name: "Tusker Lager", price: 200, store_id: store1.id},
  %{name: "Guinness Stout", price: 220, store_id: store1.id},
  %{name: "White Cap Lager", price: 210, store_id: store1.id},
  %{name: "Heineken", price: 250, store_id: store1.id},
  %{name: "Smirnoff Vodka", price: 1200, store_id: store2.id},
  %{name: "Johnnie Walker Black", price: 3500, store_id: store2.id},
  %{name: "Baileys Irish Cream", price: 2800, store_id: store2.id},
  %{name: "Martell VSOP", price: 6500, store_id: store2.id},
  %{name: "Captain Morgan Rum", price: 1800, store_id: store3.id},
  %{name: "Jack Daniels", price: 4000, store_id: store3.id},
  %{name: "Jameson Irish Whiskey", price: 3200, store_id: store3.id},
  %{name: "Glenfiddich 12", price: 6000, store_id: store3.id},
  %{name: "Gweng'fiddish", price: 50, store_id: store1.id},
  %{name: "Amarula Cream", price: 2200, store_id: store2.id},
  %{name: "Hennessy VS", price: 7000, store_id: store3.id}
]

inserted_products =
  Enum.map(products, fn attrs ->
    Repo.insert!(%Product{
      name: attrs.name,
      price: attrs.price,
      store_id: attrs.store_id
    })
  end)

# --- SAMPLE ORDER ---
order =
  Repo.insert!(%Order{
    user_id: user1.id,
    store_id: store1.id,
    status: "pending",
    order_number: "ORD-#{:rand.uniform(100_000)}",
    tracking_code: "TRK-#{:rand.uniform(999_999)}"
  })

# --- ORDER ITEMS ---
Repo.insert!(%OrderItem{
  order_id: order.id,
  product_id: Enum.at(inserted_products, 0).id, # Tusker Lager
  quantity: 2,
  price: 200
})

Repo.insert!(%OrderItem{
  order_id: order.id,
  product_id: Enum.at(inserted_products, 1).id, # Guinness Stout
  quantity: 1,
  price: 220
})

# --- PAYMENT ---
Repo.insert!(%Payment{
  order_id: order.id,
  amount: 620,
  status: "paid"
})

# --- DELIVERY ---
Repo.insert!(%Delivery{
  order_id: order.id,
  rider_id: rider.id,
  rider_name: rider.username,
  status: "on_route",
  tracking_code: order.tracking_code
})

IO.puts("Database seeded successfully!")
