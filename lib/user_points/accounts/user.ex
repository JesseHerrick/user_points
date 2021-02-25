defmodule UserPoints.Accounts.User do
  @moduledoc """
  The User schema stores data about our Users.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :points, :integer

    timestamps()
  end

  @doc """
  Builds a changeset for the User schema.

  Returns a changeset.
  """
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_number(:points, greater_than_or_equal_to: 0, less_than_or_equal_to: 100)
  end
end
