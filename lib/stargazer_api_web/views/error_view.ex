defmodule StargazerApiWeb.ErrorView do
  use StargazerApiWeb, :view

  def render("error.json", %{changeset: changeset}) do
    %{error: changeset
      |> traverse_errors()
      |> join_errors()}
  end

  def render("error.json", %{msg: msg}) do
    %{error: %{msg: msg}}
  end

  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  def traverse_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  def join_errors(errors) do
    errors
    |> Enum.reduce([], fn {k, v}, acc -> ["#{k}: #{v};" | acc] end)
    |> Enum.join("\n")
  end
end
