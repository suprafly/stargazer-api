defmodule StargazerApi.GithubRepos.GithubRepo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "github_repos" do
    field :name, :string
    field :owner, :string
    field :repo_string, :string

    timestamps()
  end

  @doc false
  def changeset(github_repo, attrs) do
    github_repo
    |> cast(attrs, [:owner, :name, :repo_string])
    |> validate_required([:owner, :name, :repo_string])
    |> unique_constraint(:repo_string)
  end
end
