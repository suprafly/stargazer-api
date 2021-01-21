defmodule StargazerApiWeb.Router do
  use StargazerApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StargazerApiWeb do
    pipe_through :api

    post "/repos", RepoController, :add_repo
    post "/repos/:owner/:name", RepoController, :get_stargazers
  end
end
