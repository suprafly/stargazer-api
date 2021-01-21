defmodule StargazerApiWeb.RepoController do
  use StargazerApiWeb, :controller

  alias StargazerApi.{GithubRepos, GithubRepos.GithubRepo, Stargazers}

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

  def get_stargazers(conn, %{"owner" => owner, "name" => name, "from" => from_date, "to" => to_date} = params) do
    with {:ok, repo} <- GithubRepos.get_repo(owner, name),
         {:ok, resp} <- Stargazers.get_new_and_former_stargazers(repo, from_date, to_date)
    do
      render(conn, "stargazers.json", resp)
    end
  end

  def get_stargazers(conn, %{"owner" => owner, "name" => name} = params) do
    IO.inspect params
    with {:ok, stargazers} <- StargazerApi.get_stargazers(owner, name, take: ["id"]) do
      render(conn, "stargazers.json", new: stargazers)
    end
  end

  def get_stargazers(conn, _params) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(StargazerApiWeb.ErrorView)
    |> render("error.json", msg: "Missing required fields")
  end
end
