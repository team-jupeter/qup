defmodule Demo.Supuls.CheckArchiveEvent do
  import Ecto.Query, warn: false
  # alias Demo.Repo
  alias Demo.Openhashes
  alias Demo.Supuls
  alias Demo.Repo
  # alias Demo.Supuls.Supul

  def check_archive_event(event, payload) do
    parts = String.split(payload, "|")

    # ? reject the payload if the timestamp is newer than the arriving time to supul. 
    recv_ts = Enum.fetch!(parts, 0)
    recv_event_id = Enum.fetch!(parts, 1)
    recv_event_hash = Enum.fetch!(parts, 2)

    {:ok, recv_sig_erl} = Enum.fetch!(parts, 3) |> Base.url_decode64()
    {:ok, recv_sig_ssu} = Enum.fetch!(parts, 4) |> Base.url_decode64()

    # ? Hard coded public keys. Those shall be obtained via public routes.

    erl_ssu =
      case event.type do
        # ? For wedding
        "wedding" ->
          %{
            erl_pub_key: ExPublicKey.load!("./keys/lee_public_key.pem"),
            ssu_pub_key: ExPublicKey.load!("./keys/sung_public_key.pem")
          }

        # #? For transaction
        "transaction" ->
          %{
            erl_pub_key: ExPublicKey.load!("./keys/hong_entity_public_key.pem"),
            ssu_pub_key: ExPublicKey.load!("./keys/tomi_public_key.pem")
          }

        # #? For transfer
        "transfer" ->
          %{
            erl_pub_key: ExPublicKey.load!("./keys/hong_entity_public_key.pem"),
            ssu_pub_key: ExPublicKey.load!("./keys/tomi_public_key.pem")
          }
      end

    # IO.puts("Do you see me? 1 ^^*")

    {:ok, sig_valid_erl} =
      ExPublicKey.verify(
        "#{recv_ts}|#{recv_event_id}|#{recv_event_hash}",
        recv_sig_erl,
        erl_ssu.erl_pub_key
      )

    {:ok, sig_valid_ssu} =
      ExPublicKey.verify(
        "#{recv_ts}|#{recv_event_id}|#{recv_event_hash}",
        recv_sig_ssu,
        erl_ssu.ssu_pub_key
      )

    # ? OPENHASH 
    erl_supul = Supuls.get_supul!(event.erl_supul_id)
    ssu_supul = Supuls.get_supul!(event.ssu_supul_id)

    {:ok, openhash} =
      cond do
        sig_valid_erl && sig_valid_ssu ->
          IO.puts("Update erl supul with recv_event_hash")

          {:ok, erl_supul} =
            Supuls.update_hash_chain(erl_supul, %{
              event_sender: event.erl_email,
              event_id: event.id,
              incoming_hash: recv_event_hash
            })

          {:ok, openhash} = Openhashes.create_openhash(erl_supul, event)

          if erl_supul.id != ssu_supul.id do
            IO.puts("Make a ssu supul struct")

            {:ok, ssu_supul} =
              Supuls.update_hash_chain(ssu_supul, %{
                event_sender: event.ssu_email,
                event_id: event.id,
                incoming_hash: recv_event_hash
              })

            # IO.inspect ssu_supul

            IO.puts("Make an openhash of ssu supul struct")
            {:ok, openhash} = Openhashes.create_openhash(ssu_supul, event)
          end

          # ? Making a family struct and related financial statements. 
          process_event(event, openhash)

        # ? halt the process 
        true ->
          IO.puts("error")
          "error"
      end
  end

  alias Demo.GabAccounts
  alias Demo.Entities.Entity

  defp process_event(event, openhash) do
    erl = Repo.one(from e in Entity, where: e.email == ^event.erl_email, select: e)
    ssu = Repo.one(from e in Entity, where: e.email == ^event.ssu_email, select: e)

    case event.type do
      "transaction" -> Supuls.ProcessTransaction.process_transaction(event, openhash)
      "wedding" -> Supuls.ProcessWedding.process_wedding(event)
      "transfer" -> GabAccounts.process_transfer(event, erl, ssu, openhash)
      _ -> IO.puts("Oh ma ma my ... type error")
    end
  end
end
