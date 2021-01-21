defmodule StargazerApi.Stargazers do
  @moduledoc """
  A context module for storing stargazers.
  """
  import Ecto.Query, only: [from: 2]

  alias StargazerApi.{GithubRepos.Daily, GithubRepos.GithubRepo, Repo}

  @doc """
  Gets a report of stargazers that have starred or unstarred over the date range.
  """
  def get_new_and_former_stargazers(%GithubRepo{} = repo, from_date, to_date) do
    with historical <- get_historical(repo.id, from_date, to_date),
         stargazers <- Enum.map(historical, & &1.stargazers)
    do
      reduce(stargazers)
    end
  end

  @doc """
  Gets a list of daily entries from the db for the date range.
  """
  def get_historical(repo_id, from_date, to_date) do
    (from d in Daily,
      where: d.repo_id == ^repo_id and
        fragment("?::date", d.date) >= ^from_date and
        fragment("?::date", d.date) <= ^to_date)
    |> Repo.all()
  end

  @doc """
  Reduces a list of lists into a map of the type, `%{new: [], former: []}`,
  where `:new` are items that have been added as we proceed through the list
  from left to right, and `:former` are the ones that have been removed.

  This returns a list of strings, and the strings describe how many times the
  operations have occurred.
  """
  def reduce([first | rest]) do
    rest
    |> Enum.reduce(%{base: first, new: [], former: []},
      fn stargazers, %{base: base} = acc ->
        {base_ms, stargazers_ms} = {MapSet.new(base), MapSet.new(stargazers)}
        # any that appear in the base but not the entry have unstarred
        former = difference(base_ms, stargazers_ms)
        # any that appear in the entry but not the base have starred
        new = difference(stargazers_ms, base_ms)
        # now we combine them into a new accumulator
        combine(acc, new, former, stargazers)
    end)
    |> parse_results()
  end

  def reduce(list) do
    list
  end

  defp difference(ms1, ms2) do
    ms1
    |> MapSet.difference(ms2)
    |> MapSet.to_list()
  end

  defp combine(acc, new, former, base) do
    %{
      base: base,
      new: insert_and_count(new, acc.new),
      former: insert_and_count(former, acc.former)
    }
  end

  defp insert_and_count(list, acc) do
    # We need to consider the case where a user stars / unstars
    # repeatedly over a span of days. In order to handle this
    # erratic behaviour, we group each entry by id, then count.
    list
    |> Enum.reduce(acc, fn id, acc -> [{id, 1} | acc] end)
    |> Enum.group_by(fn {k, _} -> k end)
    |> Enum.map(fn {k, v} -> {k, Enum.count(v)} end)
  end

  defp parse_results(%{new: new, former: former}) do
    %{
      new: Enum.map(new, &stringify(&1, "starred")),
      former: Enum.map(former, &stringify(&1, "unstarred"))
    }
  end

  defp stringify({id, 1}, type) do
    "User '#{id}' #{type}"
  end

  defp stringify({id, count}, type) do
    "User '#{id}' #{type} #{count} times"
  end
end
