defmodule MzingaDelivery.Deliveries.Delivery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "deliveries" do
    field :rider_name, :string
    field :status, :string
    field :tracking_code, :string

    belongs_to :order, MzingaDelivery.Orders.Order
    belongs_to :rider, MzingaDelivery.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(delivery, attrs) do
    delivery
    |> cast(attrs, [:rider_name, :status, :tracking_code, :order_id, :rider_id])
    |> validate_required([:rider_name, :status, :order_id])
  end
end
