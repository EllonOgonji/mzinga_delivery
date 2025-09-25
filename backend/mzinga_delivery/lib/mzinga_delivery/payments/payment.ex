defmodule MzingaDelivery.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :integer
    field :status, :string
    field :method, :string
    field :transaction_ref, :string

    belongs_to :order, MzingaDelivery.Orders.Order

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:amount, :status, :method, :transaction_ref, :order_id])
    |> validate_required([:amount, :status, :order_id])
  end
end
