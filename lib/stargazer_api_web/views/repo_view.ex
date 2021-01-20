defmodule StargazerApiWeb.RepoView do
  use StargazerApiWeb, :view

  def render("add_repo.json", %{repo: repo}) do
    %{data: render_one(repo, __MODULE__, "repo.json")}
  end

  def render("repo.json", %{repo: repo}) do
    %{owner: repo.owner, name: repo.name}
  end
end
