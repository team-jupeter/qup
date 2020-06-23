defmodule DemoWeb.Presence do
  use Phoenix.Presence,
    otp_app: :demo,
    pubsub_server: Demo.PubSub

  def fetch(_topic, entries) do
    IO.inspect "Presence.fetch"
    IO.inspect entries
    
    users =
    entries
    |> Map.keys()
    |> Demo.Accounts.list_users_with_ids()
    |> Enum.into(%{}, fn user -> 
      {to_string(user.id), %{username: user.username}} 
    end)
    
    IO.inspect users
    
    for {key, %{metas: metas}} <- entries, into: %{} do
      {key, %{metas: metas, user: users[key]}}
    end
  end
end
