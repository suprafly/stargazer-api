defmodule StargazerApiWeb.RepoController do
  use StargazerApiWeb, :controller

  def add_repo(conn, %{"user" => user, "repo" => repo}) do
    # TODO: just setting up the basic routes for now. implement this later.
  end

  def get_stargazers(conn, , %{"user" => _user, "repo" => _repo, "from" => _from_date, "to" => _to_date}) do
    # TODO: just setting up the basic routes for now. implement this later.
  end
end
