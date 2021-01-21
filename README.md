# StargazerApi

This repo contains a simple server for tracking Github Repo's stargazers.

## Getting started

Setting up and starting the API server:

  *  `mix deps.get`
  *  `mix ecto.create`
  *  `mix ecto.migrate`
  *  `cd assets && npm install && cd ..`
  *  `mix phx.server`

## Running the tests

`mix test`

## Future Scheduling Work

In order to implement the scheduler, I would use the [Quantum](https://github.com/quantum-elixir/quantum-core) elixir library for running scheduled jobs.

The implementation is simple. After installing the dependency, you can add the following config to this project:

```
config :acme, StagazerApi.Scheduler,
  jobs: [
    # Runs every midnight:
    {"29 22 * * *", {StagazerApi.Jobs, :track_daily, []}}
  ]
```

This runs our job 30 minutes before midnight, everyday.

Now, create a module named `StagazerApi.Jobs` and implement the `track_daily/0` function. This function will iterate over all repos in the `"github_repos"` db, and run request the current stargazers for each through the Github API.

Next, query the get the `"repo_stargazers_daily"` db to get a list of entries for all of the stargazers up until (but not including) today. Combine them into one list, then `Enum.dedup/2` the full list from the Github request and this list. Ex,

```
new_stargazers = Enum.dedup(all_stargazers, former_stargazers)
```

Create a new `StargazerApi.GithubRepos.Daily` entry in the db with today's date and the `new_stargazers`.