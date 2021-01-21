defmodule StargazerApi do
  @moduledoc """
  Basic functionality for the API.
  """

  alias Tentacat.{Client, Users.Starring}

  def get_stargazers(owner, repo, opts \\ []) do
    case Client.new() |> Starring.stargazers(owner, repo) do
      {200, stargazers, _resp} -> {:ok, parse_stargazers(stargazers, opts)}
      {422, _, _resp} -> {:error, :validation_failed}
      {404, %{"message" => msg}, _} -> {:error, msg}
      {status_code, _, _} -> {:error, status_code}
    end
  end

  def parse_stargazers(stargazers, opts) do
    Enum.map(stargazers, &maybe_take(&1, opts))
  end

  defp maybe_take(item, opts) do
    Map.take(item, opts[:take] || Map.keys(item))
  end
end
