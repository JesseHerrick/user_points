defmodule UserPointsWeb.UserController do
  use UserPointsWeb, :controller

  @doc """
  Returns a list of no more than two users, their points, and a timestamp of
  when the query was made.
  """
  def index(conn, _params) do
    {users, timestamp} = {[], nil} # TODO: Get users and timestamp

    render(conn, "index.json", users: users, timestamp: timestamp)
  end
end
