defmodule MzingaDeliveryWeb.SessionController do
  use MzingaDeliveryWeb, :controller

  alias MzingaDelivery.Accounts

  # --------------------------
  # Show login page
  # --------------------------
  def new(conn, _params) do
    render(conn, "new.html")
  end

  # --------------------------
  # Handle login form submission
  # --------------------------
  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Logged in successfully")
        |> redirect(to: "/")  # Change this to your app's landing page

      {:error, :invalid_credentials} ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> render("new.html")
    end
  end

  # --------------------------
  # Handle logout
  # --------------------------
  def delete(conn, _params) do
    conn
    |> configure_session(drop: true) # clears all session data
    |> put_flash(:info, "Logged out successfully")
    |> redirect(to: "/login")
  end
end
