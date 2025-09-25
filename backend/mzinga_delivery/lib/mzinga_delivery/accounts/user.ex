defmodule MzingaDelivery.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, :string, default: "customer"

    timestamps(type: :utc_datetime)
  end

  @valid_roles ~w(customer seller rider admin)

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :role])
    |> validate_required([:username, :email, :password, :role])
    |> unique_constraint(:email)
    |> validate_inclusion(:role, @valid_roles)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      password -> put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
    end
  end
end
