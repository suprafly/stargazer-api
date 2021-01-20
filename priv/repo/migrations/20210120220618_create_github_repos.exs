defmodule StargazerApi.Repo.Migrations.CreateGithubRepo do
  use Ecto.Migration

  def change do
    create table(:github_repos) do
      add :owner, :string
      add :name, :string

      timestamps()
    end

  end
end
