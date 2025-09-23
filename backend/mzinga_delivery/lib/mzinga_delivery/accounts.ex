defmodule MzingaDelivery.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias MzingaDelivery.Repo

  alias MzingaDelivery.Accounts.User

  # --------------------------
  # CRUD Functions
  # --------------------------

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  # --------------------------
  # Authentication
  # --------------------------

  @doc """
  Authenticates a user by email and plain text password.

  Returns:
    {:ok, user} if valid
    {:error, :invalid_credentials} otherwise
  """
  def authenticate_user(email, plain_text_password) do
    case Repo.get_by(User, email: email) do
      nil ->
        # Prevents timing attacks
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Bcrypt.verify_pass(plain_text_password, user.password_hash) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
