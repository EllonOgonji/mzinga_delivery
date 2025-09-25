defmodule MzingaDelivery.Stores.Store do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stores" do
    field :name, :string
    field :address, :string
    field :lat, :float
    field :lng, :float

    has_many :products, MzingaDelivery.Products.Product
    has_many :orders, MzingaDelivery.Orders.Order

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(store, attrs) do
    store
    |> cast(attrs, [:name, :address, :lat, :lng])
    |> validate_required([:name, :address])
  end
end
