defmodule UserPointsWeb.UserController do
  use UserPointsWeb, :controller

  @doc """
  Returns a list of no more than two users, their points, and a timestamp of
  when the query was made.
  """
  def index(conn, _params) do
    {users, timestamp} = UserPoints.PointsHandler.users_with_points_greater_than_max()

    render(conn, "index.json", users: users, timestamp: timestamp)
  end
end
