defmodule UserPointsWeb.UserControllerTest do
  use UserPointsWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns no more than two users with greater than the current random number of points", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["users"] == []
      assert json_response(conn, 200)["timestamp"] == nil
    end
  end
end
