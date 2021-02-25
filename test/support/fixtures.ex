defmodule UserPoints.Fixtures do
  alias UserPoints.Accounts.User
  alias UserPoints.Repo

  def user_fixture(attrs \\ %{}) do
    %User{points: UserPoints.Random.random_point()}
    |> Map.merge(attrs)
    |> Repo.insert!
  end

  def create_sample_users(count) do
    for _ <- 1..count do
      user_fixture()
    end
  end

  def map_points(users) do
    Enum.map(users, &(&1.points))
  end
end
