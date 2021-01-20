defmodule StargazerApi.Repo.Migrations.AddRepoStringToGithubRepos do
  use Ecto.Migration

  def change do
    alter table(:github_repos) do
      add :repo_string, :string, unique: true
    end

    create unique_index(:github_repos, :repo_string)
  end
end
