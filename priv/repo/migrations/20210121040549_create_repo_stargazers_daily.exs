defmodule StargazerApi.Repo.Migrations.CreateRepoStargazersDaily do
  use Ecto.Migration

  def change do
    create table(:repo_stargazers_daily) do
      add :repo_id, references(:github_repos)
      add :date, :date
      add :stargazers, {:array, :string}

      timestamps()
    end
  end
end
