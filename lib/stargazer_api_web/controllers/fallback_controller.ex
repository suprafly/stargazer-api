defmodule StargazerApiWeb.FallbackController do
  use StargazerApiWeb, :controller

  def call(conn, {:error, :invalid_format}) do
    conn
    |> update_conn()
    |> render("error.json", msg: "Invalid format for one or more of your fields")
  end

  def call(conn, {:error, msg}) do
    conn
    |> update_conn()
    |> render("error.json", msg: msg)
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> update_conn()
    |> render("error.json", changeset: changeset)
  end

  defp update_conn(conn) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(StargazerApiWeb.ErrorView)
  end
end
