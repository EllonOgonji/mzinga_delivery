defmodule MzingaDelivery.Repo.Migrations.AddMethodAndTransactionRefToPayments do
  use Ecto.Migration

  def change do
    alter table(:payments) do
     add :method, :string
      add :transaction_ref, :string
    end
  end
end
