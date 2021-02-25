defmodule UserPoints.AccountsTest do
  use UserPoints.DataCase

  alias UserPoints.Accounts

  describe "users" do
    alias UserPoints.Accounts.User

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
  end
end
