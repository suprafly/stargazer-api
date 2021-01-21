defmodule StargazerApiWeb.RepoController do
  use StargazerApiWeb, :controller

  alias StargazerApi.GithubRepos.GithubRepo

  action_fallback StargazerApiWeb.FallbackController

  def add_repo(conn, %{"owner" => owner, "name" => name} = params) do
    with repo_string <- "#{owner}/#{name}",
         attrs <- Map.put(params, "repo_string", repo_string),
         changeset <- GithubRepo.changeset(%GithubRepo{}, attrs),
         true <- changeset.valid?,
         {:ok, repo} <- StargazerApi.Repo.insert(changeset)
    do
      render(conn, "add_repo.json", repo: repo)
    end
  end

  def add_repo(conn, _params) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(StargazerApiWeb.ErrorView)
    |> render("error.json", msg: "Missing required fields")
  end

  def get_stargazers(_conn, %{"owner" => _owner, "repo" => _repo, "from" => _from_date, "to" => _to_date}) do
  end
end
