defmodule MzingaDelivery.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :quantity, :integer, null: false
      add :price, :integer, null: false

      add :order_id, references(:orders, on_delete: :delete_all), null: false
      add :product_id, references(:products, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:order_items, [:order_id])
    create index(:order_items, [:product_id])
  end
end
