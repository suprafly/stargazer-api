defmodule StargazerApiWeb.FallbackController do
  use StargazerApiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(StargazerApiWeb.ErrorView)
    |> render("error.json", changeset: changeset)
  end
end
