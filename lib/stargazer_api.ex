defmodule StargazerApi do
  @moduledoc """
  Basic functionality for the API.
  """

  alias Tentacat.{Client, Users.Starring}

  def get_stargazers(user, repo) do
    case Client.new() |> Starring.stargazers(user, repo) do
      {200, stargazers, _resp} -> {:ok, stargazers}
      {422, _, _resp} -> {:error, :validation_failed}
      {404, %{"message" => msg}, _} -> {:error, msg}
      {status_code, _, _} -> {:error, status_code}
  end
end
