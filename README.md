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

## Api Docs

Once you start the server, you can view the api docs here, [http://localhost:4000/api-docs/index.html](http://localhost:4000/api-docs/index.html)

## Future Scheduling Work

In order to implement the scheduler, I would use the [Quantum](https://github.com/quantum-elixir/quantum-core) elixir library for running scheduled jobs.

The implementation is simple. After installing the dependency, you can add the following config to this project:

```
config :acme, StagazerApi.Scheduler,
  jobs: [
    # Runs day, at 11:30 PM:
    {"29 22 * * *", {StagazerApi.Jobs, :track_daily, []}},

    # Runs day, at midnight
    # See the section 'Known Limitations' below for an explanation on how you would use this job:
    # {"@daily", {StagazerApi.Jobs, :update_daily, []}}

  ]
```

This runs our job 30 minutes before midnight, everyday.

Now, create a module named `StagazerApi.Jobs` and implement the `track_daily/0` function. This function will iterate over all repos in the `"github_repos"` db, and run a request for the current stargazers for each through the Github API.

Create a new `StargazerApi.GithubRepos.Daily` entry in the db with today's date and the stargazers. There is a function in `StargazerApi.GithubRepos`, `store_stargazers_today/1`, that will perform the data store for a given repo.

## Known Limitations

The scheduler described above runs at 11:30 PM in the timezone of the machine that is running the server. I have left a 30 minute gap before midnight in case we need to restart the machine in that timeframe, and update the scheduler to handle this sort of behaviour. The thirty minute gap means that people may still star / unstar the repo during this day, but that it will not show up until the next day.

To me this is acceptable for a proof of concept, and given that we always remain consistent. If we want to correct for this thirty minutes, we can schedule another job at midnight and then update the previous entry accordingly.
