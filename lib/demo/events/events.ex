defmodule Demo.Events do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Events.Event
  alias Demo.Supuls
  alias Demo.Weddings.Wedding
  alias Demo.Transactions.Transaction

  def list_events do
    Repo.all(Event)
  end


  def get_event!(id), do: Repo.get!(Event, id)


  # def update_event(%Event{} = event, attrs) do
  #   event
  #   |> Event.changeset(attrs) 
  #   |> Repo.update()
  # end

  
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end
  
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end
 
  def create_event(attrs) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  def create_event(event, erl_private_key, ssu_private_key) do
    {:ok, payload} = make_payload(event, erl_private_key, ssu_private_key)
    Supuls.CheckArchiveEvent.check_archive_event(event, payload)
  end   
 

  def update_event(event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  #? 혼인신고서, 거래계약서, ....
  defp make_payload(event, erl_private_key, ssu_private_key) do
    ts = DateTime.utc_now() |> DateTime.to_unix()
    event_id = event.id 

    event_serialized = Poison.encode!(event)
    event_hash = Pbkdf2.hash_pwd_salt(event_serialized)


    event_msg = "#{ts}|#{event_id}|#{event_hash}"

    {:ok, erl_signature} = ExPublicKey.sign(event_msg, erl_private_key)
    {:ok, ssu_signature} = ExPublicKey.sign(event_msg, ssu_private_key)

    payload = "#{ts}|#{event_id}|#{event_hash}|#{Base.url_encode64(erl_signature)}|#{Base.url_encode64(ssu_signature)}"
    
    #? Attach payload to wedding for verification by anybody. 
    case event.type do
      "wedding" -> Wedding.changeset(event, %{payload: payload})
        |> Repo.update()
  
      "transaction" -> Transaction.changeset(event, %{payload: payload})
      |> Repo.update()
      _ -> "error" 
    end
    {:ok, payload}
  end
  
end
