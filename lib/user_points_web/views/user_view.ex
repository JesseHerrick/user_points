defmodule UserPointsWeb.UserView do
  @moduledoc """
  View for rendering JSON for the users API endpoint.
  """

  use UserPointsWeb, :view
  alias UserPointsWeb.UserView

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{
      users: render_many(users, UserView, "user.json"),
      timestamp: format_datetime(timestamp)
    }
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      points: user.points
    }
  end

  defp format_datetime(nil), do: nil
  defp format_datetime(timestamp) do
    Calendar.strftime(timestamp, "%c")
  end
end
