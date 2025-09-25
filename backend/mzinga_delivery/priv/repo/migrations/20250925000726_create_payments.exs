defmodule MzingaDelivery.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :amount, :integer, null: false
      add :status, :string, null: false

      add :order_id, references(:orders, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:payments, [:order_id])
  end
end
