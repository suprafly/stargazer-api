defmodule StargazerApi.GithubRepos do
  @moduledoc """
  Context module for GithubRepos
  """
  alias StargazerApi.{GithubRepos.Daily, GithubRepos.GithubRepo, Repo}

  @doc """
  Gets the stargazers for today for a given repo and stores them. In order
  to save space, we only store the `id`'s of the users, because we can always
  rehtdrate the users later if we need more information.

  If an entry already exists for the given repo on this day, then the
  function will fail.
  """
  def store_stargazers_today(%GithubRepo{} = repo) do
    with today <- Date.utc_today(),
         {:ok, _} <- can_insert?(repo, today),
         {:ok, stargazers} <- StargazerApi.get_stargazers(repo.owner, repo.name, take: ["id"]),
         attrs <- %{"repo_id" => repo.id, "date" => today, "stargazers" => stargazers},
         changeset <- Daily.changeset(%Daily{}, attrs),
         {:ok, entry} <- Repo.insert(changeset)
    do
      {:ok, entry}
    end
  end

  defp can_insert?(repo, date) do
    case Repo.get_by(Daily, repo_id: repo.id, date: date) do
      nil -> {:ok, :no_entry}
      _ -> {:error, :entry_exists}
    end
  end
end
