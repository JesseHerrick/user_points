defmodule UserPoints.AccountsTest do
  use UserPoints.DataCase, async: true

  import Ecto.Query

  alias UserPoints.Accounts

  describe "users" do
    alias UserPoints.Accounts.User
    import UserPoints.Fixtures

    test "create_user/1 with valid data creates a user" do
      for points <- [0, 1, 25, 98, 100] do
        assert {:ok, %User{} = user} = Accounts.create_user(%{points: points})
        assert user.points == points
      end
    end

    test "create_user/1 with invalid data returns error changeset" do
      for points <- [-10, -1, 101, 1000] do
        assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{points: points})
      end
    end

    test "change_user/1 returns a user changeset" do
      assert %Ecto.Changeset{} = Accounts.change_user(%{points: 10})
    end

    test "list_users/0 returns all users in the database" do
      user_count = 7
      create_sample_users(user_count)

      assert user_count == length(Accounts.list_users())
    end

    test "reset_points/1 sets a given user's points to a random number from 0 through 100" do
      user = user_fixture()
      assert {:ok, updated_user} = Accounts.reset_points(user)
      refute user.points == updated_user.points
    end

    test "reset_all_points/0 sets all users in the DB's points to a random number from 0 through 100" do
      old_user_points =
        create_sample_users(10)
        |> Enum.map(fn user -> {user.id, user.points} end)

      assert :ok = Accounts.reset_all_points()

      new_user_points = from(u in Accounts.User, select: {u.id, u.points}) |> UserPoints.Repo.all()

      refute old_user_points == new_user_points
    end

    test "users_with_points_greater_than/1 returns no more than 2 users with points greater than max_number" do
      for points <- [100, 1, 20, 0, 40, 99, 50, 51, 51, 58, 99] do
        user_fixture(%{points: points})
      end

      assert [100, 99] == map_points(Accounts.users_with_points_greater_than(1))
      assert [100, 99] == map_points(Accounts.users_with_points_greater_than(50))
      assert [100] == map_points(Accounts.users_with_points_greater_than(99))
    end
  end
end
