defmodule MzingaDelivery.Repo.Migrations.CreateDeliveries do
  use Ecto.Migration

  def change do
    create table(:deliveries) do
      add :rider_name, :string, null: false
      add :status, :string, null: false
      add :tracking_code, :string

      add :order_id, references(:orders, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:deliveries, [:order_id])
  end
end
