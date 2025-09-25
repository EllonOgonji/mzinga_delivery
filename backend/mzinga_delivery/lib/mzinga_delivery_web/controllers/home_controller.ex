defmodule MzingaDeliveryWeb.HomeController do
  use MzingaDeliveryWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome to Mzinga Delivery!")
  end
end
