defmodule StargazerApi.GithubRepos.Daily do
  use Ecto.Schema
  import Ecto.Changeset

  alias StargazerApi.GithubRepos.GithubRepo

  schema "repo_stargazers_daily" do
    field :date, :date
    field :stargazers, {:array, :string}

    belongs_to :repo, GithubRepo

    timestamps()
  end

  @doc false
  def changeset(daily, attrs) do
    daily
    |> cast(attrs, [:repo_id, :date, :stargazers])
    |> validate_required([:date, :stargazers])
    |> assoc_constraint(:repo)
  end
end
