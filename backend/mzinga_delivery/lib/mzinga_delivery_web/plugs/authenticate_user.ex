defmodule MzingaDeliveryWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias MzingaDelivery.Accounts
  alias MzingaDeliveryWeb.Router.Helpers, as: Routes

  def init(default), do: default

  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "You must be logged in to access this page")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()

      user_id ->
        user = Accounts.get_user!(user_id)
        assign(conn, :current_user, user)
    end
  end
end
