defmodule UserPoints.Accounts do
  @moduledoc """
  The `UserPoints.Accounts` module serves as the context for actions taken on
  `UserPoints.Accounts.Users`.
  """

  alias UserPoints.Accounts.User
  alias UserPoints.Repo

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
end
