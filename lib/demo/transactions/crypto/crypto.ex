# lib/encrypt.ex

defmodule Encrypt do
  @moduledoc """
  Documentation for Encrypt.
  """

  @doc """
  `generate_secret`
  Generates a random base64 encoded secret key.
  """
  def generate_secret do
    :crypto.strong_rand_bytes(16) \
    |> :base64.encode
  end
end