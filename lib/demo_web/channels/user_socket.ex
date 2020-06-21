defmodule DemoWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "videos:*", DemoWeb.VideoChannel

  @max_age 2 * 7 * 24 * 60 * 60

  def connect(%{"token" => token}, socket, _connect_info) do
    case Phoenix.Token.verify(
      socket, 
      "user socket", 
      token, 
      max_age: @max_age
    ) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}

      {:error, _reason} ->
        :error
    end
  end

  def connect(_params, _socket, _connect_info), do: :error

  def id(socket), do: "users_socket:#{socket.assigns.user_id}"
end

