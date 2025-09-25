defmodule MzingaDelivery.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, null: false
      add :price, :integer, null: false
      add :store_id, references(:stores, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:products, [:store_id])
  end
end
