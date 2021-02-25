defmodule UserPoints.PointsHandlerTest do
  use UserPoints.DataCase

  alias UserPoints.{PointsHandler, Accounts}

  import UserPoints.Fixtures
  import Ecto.Query

  test "the process should be started in the supervision tree and named PointsHandler" do
    assert Process.alive?(GenServer.whereis(PointsHandler))
  end

  describe "handle_call/3 :: :users_with_points_greater_than_max" do
    test "returns the expected timestamps and users, not changing max_number" do
      for points <- [100, 51, 51, 58, 80] do
        user_fixture(%{points: points})
      end

      assert {:reply, {users, nil}, {10, new_timestamp}} = PointsHandler.handle_call(:users_with_points_greater_than_max, self(), {10, nil})
      refute new_timestamp == nil
      assert [100, 80] == map_points(users)

      last_timestamp = DateTime.now!("Etc/UTC")
      assert {:reply, {users, resp_timestamp}, {89, new_timestamp}} = PointsHandler.handle_call(:users_with_points_greater_than_max, self(), {89, last_timestamp})
      assert [100] == map_points(users)
      assert resp_timestamp == last_timestamp
      refute resp_timestamp == new_timestamp
    end
  end

  describe "handle_info/2 :: :reset_max_number_and_points" do
    test "resets all users' points and updates the max_number" do
      old_user_points =
        create_sample_users(10)
        |> Enum.map(fn user -> {user.id, user.points} end)

      old_max_number = 80
      assert {:noreply, {new_max_number, resp_timestamp}} = PointsHandler.handle_info(:reset_max_number_and_points, {old_max_number, nil})
      assert resp_timestamp == nil
      refute new_max_number == old_max_number

      new_user_points = from(u in Accounts.User, select: {u.id, u.points}) |> UserPoints.Repo.all()
      refute old_user_points == new_user_points
    end
  end
end
