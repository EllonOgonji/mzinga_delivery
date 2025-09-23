defmodule MzingaDeliveryWeb.Router do
  use MzingaDeliveryWeb, :router

  alias MzingaDeliveryWeb.Plugs.AuthenticateUser

  # --------------------------
  # Browser pipeline
  # --------------------------
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # Pipeline for authenticated users
  pipeline :require_authenticated_user do
    plug AuthenticateUser
  end

  # --------------------------
  # Public routes
  # --------------------------
  scope "/", MzingaDeliveryWeb do
    pipe_through :browser

    get "/", PageController, :index             # Home page
    get "/login", SessionController, :new      # Login page
    post "/login", SessionController, :create  # Login submission
    get "/register", UserController, :new      # Registration page
    post "/register", UserController, :create  # Create user
  end

  # --------------------------
  # Protected routes
  # --------------------------
  scope "/", MzingaDeliveryWeb do
    pipe_through [:browser, :require_authenticated_user]

    delete "/logout", SessionController, :delete  # Logout
    get "/dashboard", DashboardController, :index # Dashboard for logged-in users
    get "/profile", UserController, :show         # User profile page
    # Add more protected routes here
  end

  # --------------------------
  # API routes
  # --------------------------
  scope "/api", MzingaDeliveryWeb do
    pipe_through :api
    # Add API endpoints here
  end

  # --------------------------
  # Dev-only routes
  # --------------------------
  if Application.compile_env(:mzinga_delivery, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: MzingaDeliveryWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
