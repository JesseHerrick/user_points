defmodule UserPointsWeb.UserViewTest do
  use UserPointsWeb.ConnCase, async: true
  alias UserPointsWeb.UserView

  import Phoenix.View

  test "renders index.json with users and a nil timestamp" do
    users = [%{id: 1, points: 20}, %{id: 5, points: 25}]
    rendered = render(UserView, "index.json", %{users: users, timestamp: nil})

    assert %{timestamp: nil, users: users} == rendered
  end

  test "renders index.json with users and a timestamp" do
    users = [%{id: 1, points: 20}, %{id: 5, points: 25}]
    timestamp = DateTime.now!("Etc/UTC")
    rendered = render(UserView, "index.json", %{users: users, timestamp: timestamp})

    assert %{timestamp: Calendar.strftime(timestamp, "%c"), users: users} == rendered
  end

  test "renders user.json" do
    user = %{id: 2, points: 100}
    rendered = render(UserView, "user.json", %{user: user})

    assert user == rendered
  end
end
