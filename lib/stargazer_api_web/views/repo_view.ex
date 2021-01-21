defmodule StargazerApiWeb.RepoView do
  use StargazerApiWeb, :view

  def render("add_repo.json", %{repo: repo}) do
    %{data: render_one(repo, __MODULE__, "repo.json")}
  end

  def render("repo.json", %{repo: repo}) do
    %{owner: repo.owner, name: repo.name}
  end

  def render("stargazers.json", %{former: former, new: new}) do
    %{former: former, new: new}
  end

  def render("stargazers.json", %{former: stargazers}) do
    %{former: stargazers}
  end

  def render("stargazers.json", %{new: stargazers}) do
    %{new: stargazers}
  end
end
