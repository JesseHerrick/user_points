defmodule UserPoints do
  @moduledoc """
  UserPoints is an exercise in building an API endpoint to query for no more
  than two users with points more than a random `max_number` set every minute in
  the `PointsHandler` GenServer. It periodically resets the random points on 100
  different users along with the global `max_number` within the `PointsHandler`
  GenServer.
  """
end
