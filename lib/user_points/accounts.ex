defmodule UserPoints.Accounts do
  @moduledoc """
  The `UserPoints.Accounts` module serves as the context for actions taken on
  `UserPoints.Accounts.Users`.
  """

  alias UserPoints.Accounts.User
  alias UserPoints.Random
  alias UserPoints.Repo

  import Ecto.Query

  @doc """
  Creates a user changeset with the given `attrs`.
  """
  def change_user(attrs) do
    User.changeset(%User{}, attrs)
  end

  @doc """
  Creates a user in the database with the given `attrs`.
  """
  def create_user(attrs) do
    attrs
    |> change_user()
    |> Repo.insert()
  end

  @doc """
  Updates a user's points with a random number from 0 to 100.
  """
  def reset_points(user) do
    user
    |> User.changeset(%{points: Random.random_point()})
    |> Repo.update()
  end

  @doc """
  Updates every user's points with a random number from 0 to 100.

  Calls `reset_points/1` on every user found and verifies success. A
  failure to update one of the users will crash the caller.
  """
  def reset_all_points do
    Enum.each(list_users(), fn user ->
      {:ok, _} = reset_points(user)
    end)
  end

  @doc """
  Returns all users in the database.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Returns no more than two of the users with the highest score greater than
  `max_number`.
  """
  def users_with_points_greater_than(max_number) when is_integer(max_number) do
    from(
      u in User,
      where: u.points > ^max_number,
      order_by: [desc: u.points],
      limit: 2
    ) |> Repo.all()
  end
end
