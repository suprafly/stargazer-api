defmodule StargazersApi.GithubReposTest do
  use ExUnit.Case

  alias StargazerApi.{GithubRepos, GithubRepos.GithubRepo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(StargazerApi.Repo)
  end

  test "test adding a repo and retrieving it" do
    with {owner, name} <- {"phoenixframework", "phoenix"},
         attrs <- %{"owner" => owner, "name" => name, "repo_string" => "#{owner}/#{name}"},
         changeset <- GithubRepo.changeset(%GithubRepo{}, attrs),
         true <- changeset.valid?
    do
      assert {:ok, repo} = StargazerApi.Repo.insert(changeset)
      assert {:ok, get_repo} = GithubRepos.get_repo(owner, name)
      assert repo == get_repo
    end
  end

  # Skipping this test for now:
  # TODO: We need to be careful here and consider how we will approach mocking the data
  #       that would be returned by the GH api.
  # test "test store_stargazers_today/1" do
  # end
end