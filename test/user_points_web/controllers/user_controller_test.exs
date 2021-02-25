defmodule UserPointsWeb.UserControllerTest do
  use UserPointsWeb.ConnCase
  import UserPoints.Fixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns no more than two users with greater than the current random number of points, along with the timestamp of the previous query", %{conn: conn} do
      create_sample_users(100)

      conn = get(conn, Routes.user_path(conn, :index))
      last_timestamp = DateTime.now!("Etc/UTC") |> Calendar.strftime("%c")
      {users, _} = UserPoints.PointsHandler.users_with_points_greater_than_max()

      assert json_response(conn, 200)["users"] == Enum.map(users, fn u -> %{"id" => u.id, "points" => u.points} end)
      assert json_response(conn, 200)["timestamp"] == nil

      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["users"] == Enum.map(users, fn u -> %{"id" => u.id, "points" => u.points} end)
      assert json_response(conn, 200)["timestamp"] == last_timestamp
    end
  end
end
