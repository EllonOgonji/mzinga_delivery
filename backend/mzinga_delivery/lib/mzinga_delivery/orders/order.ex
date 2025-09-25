defmodule MzingaDelivery.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :order_number, :string
    field :status, :string
    field :total_price, :integer
    field :tracking_code, :string

    belongs_to :user, MzingaDelivery.Accounts.User
    belongs_to :store, MzingaDelivery.Stores.Store
    has_many :order_items, MzingaDelivery.Orders.OrderItem

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:tracking_code, :order_number, :status, :total_price, :user_id, :store_id])
    |> validate_required([:order_number, :status, :total_price, :user_id, :store_id])
  end
end
