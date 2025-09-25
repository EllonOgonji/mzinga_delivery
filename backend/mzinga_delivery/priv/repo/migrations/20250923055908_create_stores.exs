defmodule MzingaDelivery.Repo.Migrations.CreateStores do
  use Ecto.Migration

  def change do
    create table(:stores) do
      add :name, :string
      add :address, :string
      add :lat, :float
      add :lng, :float

      timestamps(type: :utc_datetime)
    end
  end
end
