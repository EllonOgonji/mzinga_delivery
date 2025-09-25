defmodule MzingaDelivery.Orders.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_items" do
    field :quantity, :integer
    field :price, :integer

    belongs_to :order, MzingaDelivery.Orders.Order
    belongs_to :product, MzingaDelivery.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:quantity, :price, :order_id, :product_id])
    |> validate_required([:quantity, :price, :order_id, :product_id])
  end
end
