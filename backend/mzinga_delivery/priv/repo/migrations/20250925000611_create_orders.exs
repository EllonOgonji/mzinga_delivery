defmodule MzingaDelivery.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :status, :string, null: false
      add :total_price, :integer, default: 0
      add :order_number, :string
      add :tracking_code, :string

      add :user_id, references(:users, on_delete: :nothing), null: false
      add :store_id, references(:stores, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:orders, [:user_id])
    create index(:orders, [:store_id])
    create unique_index(:orders, [:order_number])
  end
end
