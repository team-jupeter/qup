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
    erl_pub_key = ExPublicKey.load!("./keys/lee_public_key.pem")
    ssu_pub_key = ExPublicKey.load!("./keys/sung_public_key.pem")

    # IO.puts("Do you see me? 1 ^^*")

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

    # ? OPENHASH 
    cond do
      sig_valid_erl && sig_valid_ssu ->
        IO.puts("Make a erl supul struct")

        Supuls.update_supul(erl_supul, %{
          event_sender: event.erl_email,
          event_id: event.id,
          incoming_hash: recv_event_hash
        })

        IO.puts("Make an openhash of erl supul struct")
        openhash = Openhashes.create_openhash(erl_supul, event)
        IO.inspect openhash

        # ? BOOKKEEPING 
        process_event(event, openhash)

        if erl_supul.id != ssu_supul.id do
          IO.puts("Make a ssu supul struct")

          Supul.changeset(ssu_supul, %{
            event_sender: event.ssu_email,
            event_id: event.id,
            incoming_hash: recv_event_hash
          })
          |> Repo.update!()

          IO.puts("Make an openhash of ssu supul struct")
          openhash = Openhashes.create_openhash(ssu_supul, event)

        # ? BOOKKEEPING 
        process_event(event, %{openhash: openhash})

        end

      # ? halt the process 
      true ->
        IO.puts("error")
        "error"
    end
  end

  defp process_event(event, openhash) do
    case event.type do
      "transaction" -> Supuls.ProcessTransaction.process_transaction(event, openhash)
      "wedding" -> Supuls.ProcessWedding.process_wedding(event, openhash)
      _ -> IO.puts("Oh ma ma my ... type error")
    end
  end
end
