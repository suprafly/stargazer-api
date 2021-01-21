defmodule StargazerApi.Stargazers do
  @moduledoc """
  A context module for storing stargazers.
  """
  import Ecto.Query, only: [from: 2]

  alias StargazerApi.{GithubRepos.Daily, GithubRepos.GithubRepo, Repo}

  def get_new_stargazers(%GithubRepo{} = repo, from_date, to_date) do
    with today <- Date.utc_today(),
         {:exists?, nil} <- {:exists?, Repo.get_by(Daily, date: today)},
         {:ok, stargazers} <- StargazerApi.get_stargazers(repo.owner, repo.name, take: ["id"]),
         former <- get_former(repo.id, from_date, to_date),
         new_stargazers <- Enum.dedup(stargazers, former),
         # create new daily entry
         attrs <- %{"repo_id" => repo.id, "date" => today, "stargazers" => new_stargazers},
         changeset <- Daily.changeset(%Daily{}, attrs),
         {:valid?, true, _} <- {:valid?, changeset.valid?, changeset},
         {:ok, entry} <- Repo.insert(changeset)
    do
      {:ok, %{new: entry.stargazers, former: former}}
    else
      {:exists?, _} ->
        {:error, :entry_exists}
      {:valid?, false, changeset} ->
        {:error, changeset}
      {:error, error} ->
        {:error, error}
    end
  end

  defp get_former(repo_id, from_date, to_date) do
    (from d in Daily,
      where: d.repo_id == ^repo_id and
        fragment("?::date", d.date) >= ^from_date and
        fragment("?::date", d.date) <= ^to_date)
    |> Repo.all()
    |> Enum.map(& &1.stargazers)
  end
end
