defmodule Demo.Supuls.CheckArchiveEvent do
  import Ecto.Query, warn: false
  alias Demo.Repo
  alias Demo.Openhashes
  alias Demo.Supuls
  alias Demo.Supuls.Supul

  def check_archive_event(event, payload) do
    erl_supul = Supuls.get_supul!(event.erl_supul_id)
    ssu_supul = Supuls.get_supul!(event.ssu_supul_id)

    parts = String.split(payload, "|")

    # ? reject the payload if the timestamp is newer than the arriving time to supul. 
    recv_ts = Enum.fetch!(parts, 0)
    recv_event_id = Enum.fetch!(parts, 1)
    recv_event_hash = Enum.fetch!(parts, 2)

    {:ok, recv_sig_erl} = Enum.fetch!(parts, 3) |> Base.url_decode64()
    {:ok, recv_sig_ssu} = Enum.fetch!(parts, 4) |> Base.url_decode64()

    # ? Hard coded public keys. Those shall be obtained via public routes.
    erl_pub_key = ExPublicKey.load!("./keys/hong_entity_public_key.pem")
    ssu_pub_key = ExPublicKey.load!("./keys/tomi_public_key.pem")

    IO.puts("Do you see me? 1 ^^*")

    {:ok, sig_valid_erl} =
      ExPublicKey.verify(
        "#{recv_ts}|#{recv_event_id}|#{recv_event_hash}",
        recv_sig_erl,
        erl_pub_key
      )

    {:ok, sig_valid_ssu} =
      ExPublicKey.verify(
        "#{recv_ts}|#{recv_event_id}|#{recv_event_hash}",
        recv_sig_ssu,
        ssu_pub_key
      )


    #? OPENHASH start
    cond do
      sig_valid_erl && sig_valid_ssu ->
        make_event_hash(erl_supul, event.erl_id, recv_event_hash, event.id)
        Openhashes.create_openhash(erl_supul, event)

        if erl_supul.id != ssu_supul.id do
          make_event_hash(ssu_supul, event.ssu_id, recv_event_hash, event.id)
          Openhashes.create_openhash(ssu_supul, event)
        end

      # ? halt the process 
      true ->
        "error"
    end

    #? BOOKKEEPING start
    process_event(event)

  end

  defp make_event_hash(supul, id, recv_event_hash, event_id) do
    Supul.changeset_event_hash(supul, %{
      sender: id,
      event_id: event_id,
      incoming_hash: recv_event_hash
    })
    |> Repo.update!()
  end

  defp process_event(event) do
    IO.puts("Do you see me? 2 ^^*")

    case event.type do
      "transaction" -> Supuls.ProcessTransaction.process_transaction(event)
      "wedding" -> Supuls.ProcessWedding.process_wedding(event)
      _ -> IO.puts "Oh ma ma my ... type error"
    end
  end
end
