defmodule StargazerApiWeb.Router do
  use StargazerApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StargazerApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", StargazerApiWeb do
    pipe_through :api

    post "/repos/:user/:repo", RepoController, :add_repo
    get "/repos/:user/:repo", RepoController, :get_stargazers
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: StargazerApiWeb.Telemetry
    end
  end
end
