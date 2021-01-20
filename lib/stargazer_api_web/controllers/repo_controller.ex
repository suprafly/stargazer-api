defmodule StargazerApiWeb.RepoController do
  use StargazerApiWeb, :controller

  alias StargazerApi.GithubRepos.GithubRepo

  def add_repo(conn, %{"owner" => owner, "name" => name} = params) do
    with repo_string <- "#{owner}/#{name}",
         attrs <- Map.put(params, "repo_string", repo_string),
         changeset <- GithubRepo.changeset(%GithubRepo{}, attrs),
         true <- changeset.valid?,
         {:ok, repo} <- StargazerApi.Repo.insert(changeset)
    do
      # json(conn, %{})
      render(conn, "add_repo.json", repo: repo)
    end
  end

  def get_stargazers(_conn, %{"owner" => _owner, "repo" => _repo, "from" => _from_date, "to" => _to_date}) do
    # TODO: just setting up the basic routes for now. implement this later.
  end
end
