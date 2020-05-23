# lib/encrypt.ex

defmodule Encrypt do
  @moduledoc """
  Documentation for Encrypt.
  """

  @doc """
  `generate_secret`
  Generates a random base64 encoded secret key.
  """
  @aad "AES256GCM"

  def generate_secret do
    :crypto.strong_rand_bytes(16) \
    |> :base64.encode
  end

  def encrypt(val, key) do
    mode       = :aes_gcm
    secret_key = :base64.decode(key)
    iv         = :crypto.strong_rand_bytes(16)
    {ciphertext, ciphertag} = :crypto.block_encrypt(mode, secret_key, {@aad, to_string(val), 16})
    iv <> ciphertag <> ciphertext
    |> :base64.encode
  end
end