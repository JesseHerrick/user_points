defmodule UserPoints.PointsHandler do
  @moduledoc """
  GenServer for storing and setting the current maximum number of points, along
  with the timestamp of the last query for users with more than the current
  maximum number of points.

  This GenServer is started within the application supervision tree and updates
  the currently set `max_number` every minute to a new random number from 0 to
  100.

  It also handles calls requesting no more than two users with more points than
  the current `max_number` state. It stores the timestamps of these calls and
  returns the timestamp of the previous request whenever a new call is made to
  with the `:users_greater_than_max` pattern.
  """

  use GenServer

  alias UserPoints.{Accounts, Random}

  @reset_points_after 60_000

  def start_link(opts \\ []) do
    name = Keyword.get(opts, :name, __MODULE__)

    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  @impl true
  @doc """
  Establishes the GenServer and triggers a timer that resets the `max_number`
  state every minute.

  The beginning state of `UserPoints.PointsHandler` is always a tuple with a
  random number (our max number) from 0 to 100 and `nil` (our beginning
  timestamp).
  """
  def init(:ok) do
    schedule_reset_max_number_and_points()

    {:ok, {Random.random_point(), nil}}
  end

  @doc """
  Makes a call to the `UserPoints.PointsHandler` GenServer requesting no more
  than two users who have points greater than the current `max_number` state,
  along with the timestamp of the previous call request.

  The call will also reset the last request timestamp of the GenServer to the
  current time in UTC.
  """
  def users_with_points_greater_than_max do
    GenServer.call(__MODULE__, :users_with_points_greater_than_max)
  end

  @impl true
  def handle_call(:users_with_points_greater_than_max, _, {max_number, timestamp}) do
    users = Accounts.users_with_points_greater_than(max_number)

    {:reply, {users, timestamp}, {max_number, generate_timestamp()}}
  end

  @impl true
  def handle_info(:reset_max_number_and_points, {_, timestamp}) do
    Accounts.reset_all_points()

    schedule_reset_max_number_and_points()

    {:noreply, {Random.random_point(), timestamp}}
  end

  defp schedule_reset_max_number_and_points do
    Process.send_after(self(), :reset_max_number_and_points, @reset_points_after)
  end

  defp generate_timestamp do
    DateTime.now!("Etc/UTC")
  end
end
