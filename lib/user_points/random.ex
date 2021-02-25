defmodule UserPoints.Random do
  @moduledoc """
  Module for generating uniform random numbers.
  """

  @max_number 100

  @doc """
  Generates a random number between 0 and `@max_number`, which is currently 100.
  """
  def random_point do
    :random.uniform(@max_number + 1) - 1
  end
end
