defmodule StargazersApi.StargazersTest do
  use ExUnit.Case

  alias StargazerApi.Stargazers

  test "test reduce/1 simple - star" do
    history = [
      [1, 2, 3],
      [1, 2, 3, 4],
      [1, 2, 3, 4, 5]
    ]

    assert Stargazers.reduce(history) == {:ok, %{
      former: [],
      new: ["User '4' starred", "User '5' starred"]}
    }
  end

  test "test reduce/1 simple - unstar" do
    history = [
      [1, 2, 3, 4, 5],
      [1, 2, 3, 4],
      [1, 2, 3]
    ]

    assert Stargazers.reduce(history) == {:ok, %{
      former: ["User '4' unstarred", "User '5' unstarred"],
      new: []
    }}
  end

  test "test reduce/1 complex history" do
    history = [
      [1, 2, 3],
      [1, 2, 3, 4],
      [2, 3, 4],
      [2, 3, 5]
    ]

    assert Stargazers.reduce(history) == {:ok, %{
      former: ["User '1' unstarred", "User '4' unstarred"],
      new: ["User '4' starred", "User '5' starred"]}
    }
  end
end