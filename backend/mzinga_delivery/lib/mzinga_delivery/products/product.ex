defmodule MzingaDelivery.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :price, :integer

    belongs_to :store, MzingaDelivery.Stores.Store

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :store_id])
    |> validate_required([:name, :price, :store_id])
  end
end
