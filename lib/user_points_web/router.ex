defmodule UserPointsWeb.Router do
  use UserPointsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UserPointsWeb do
    pipe_through :api

    get "/", UserController, :index
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: UserPointsWeb.Telemetry
    end
  end
end
