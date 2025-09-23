defmodule MzingaDelivery.Repo.Migrations.AddRoleToUsers do
  use Ecto.Migration

  def change do

    alter table(:users) do
      add :role, :string, default: "customer"
    end

    create constraint(:users, :role_must_be_valid, check: "role IN ('customer', 'seller', 'rider', 'admin')")
  end
end
