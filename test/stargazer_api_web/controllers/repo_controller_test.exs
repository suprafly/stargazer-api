defmodule StargazerApiWeb.RepoControllerTest do
  use StargazerApiWeb.ConnCase

  test "POST invalid /repos", %{conn: conn} do
    conn = post(conn, "api/repos/")
    assert json_response(conn, 422) == %{"error" => %{"msg" => "Missing required fields"}}
  end

  test "POST valid /repos", %{conn: conn} do
    conn = post(conn, "api/repos/", %{"owner" => "phoenixframework", "name" => "phoenixframework"})
    assert json_response(conn, 200) == %{"name" => "phoenixframework", "owner" => "phoenixframework"}
  end

  test "POST invalid /repos/:owner/:name/history", %{conn: conn} do
    conn = get(conn, "api/repos/phoenixframework/phoenixframework/history", %{})
    assert json_response(conn, 422) == %{"error" => %{"msg" => "Missing required fields"}}
  end

  test "POST no repo /repos/:owner/:name/history", %{conn: conn} do
    conn = get(conn, "api/repos/phoenixframework/phoenixframework/history", %{"from" => "11-20-2020", "to" => "12-2-2020"})
    assert json_response(conn, 422) == %{"error" => %{"msg" => "No repo found"}}
  end

  test "POST invalid dates /repos/:owner/:name/history", %{conn: conn} do
    conn = post(conn, "api/repos/", %{"owner" => "phoenixframework", "name" => "phoenixframework"})
    assert json_response(conn, 200) == %{"name" => "phoenixframework", "owner" => "phoenixframework"}

    conn = get(conn, "api/repos/phoenixframework/phoenixframework/history", %{"from" => "11-20-2020", "to" => "12-2-2020"})
    assert json_response(conn, 422) == %{"error" => %{"msg" => "Invalid format for date. Please use 'YYYY-MM-DD' instead."}}
  end

  # Skipping this test for now:
  # TODO: We need to be careful here and consider how we will approach mocking the data
  #       that would be returned by the GH api.
  # test "POST valid dates /repos/:owner/:name/history", %{conn: conn} do
  # end
end
