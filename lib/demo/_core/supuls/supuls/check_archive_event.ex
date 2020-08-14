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

    {:ok, recv_sig_input} = Enum.fetch!(parts, 3) |> Base.url_decode64()
    {:ok, recv_sig_output} = Enum.fetch!(parts, 4) |> Base.url_decode64()

    # ? Hard coded public keys. Those shall be obtained via public routes.

    input_output =
      case event.type do
        # ? For wedding
        "wedding" ->
          %{
            input_pub_key: ExPublicKey.load!("./keys/lee_public_key.pem"),
            output_pub_key: ExPublicKey.load!("./keys/sung_public_key.pem")
          }

        # #? For transaction
        "transaction" ->
          %{
            input_pub_key: ExPublicKey.load!("./keys/hong_entity_public_key.pem"),
            output_pub_key: ExPublicKey.load!("./keys/tomi_public_key.pem")
          }

        # #? For transfer
        "transfer" ->
          %{
            input_pub_key: ExPublicKey.load!("./keys/hong_entity_public_key.pem"),
            output_pub_key: ExPublicKey.load!("./keys/tomi_public_key.pem")
          }
      end

    IO.puts("Do you see me? 1 ^^*")

    {:ok, sig_valid_input} =
      ExPublicKey.verify(
        "#{recv_ts}|#{recv_event_id}|#{recv_event_hash}",
        recv_sig_input,
        input_output.input_pub_key
      )

    {:ok, sig_valid_output} =
      ExPublicKey.verify(
        "#{recv_ts}|#{recv_event_id}|#{recv_event_hash}",
        recv_sig_output,
        input_output.output_pub_key
      )

    # ? OPENHASH 
    input_supul = Supuls.get_supul!(event.input_supul_id)
    output_supul = Supuls.get_supul!(event.output_supul_id)

    {:ok, openhash} =
      cond do
        sig_valid_input && sig_valid_output ->
          IO.puts("Update input supul with recv_event_hash")

          {:ok, input_supul} =
            Supuls.update_hash_chain(input_supul, %{
              event_sender: event.input_email,
              event_id: event.id,
              incoming_hash: recv_event_hash
            })

          {:ok, openhash} = Openhashes.create_openhash(input_supul, event)

          if input_supul.id != output_supul.id do
            IO.puts("Make a output supul struct")

            {:ok, output_supul} =
              Supuls.update_hash_chain(output_supul, %{
                event_sender: event.output_email,
                event_id: event.id,
                incoming_hash: recv_event_hash
              })

            # IO.inspect output_supul

            IO.puts("Make an openhash of output supul struct")
            {:ok, openhash} = Openhashes.create_openhash(output_supul, event)
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
    IO.puts("Do you see me? 2 ^^*")

    input = Repo.one(from e in Entity, where: e.email == ^event.input_email, select: e)
    output = Repo.one(from e in Entity, where: e.email == ^event.output_email, select: e)

    case event.type do
      "transaction" -> Supuls.ProcessTransaction.process_transaction(event, openhash)
      "wedding" -> Supuls.ProcessWedding.process_wedding(event)
      "transfer" -> GabAccounts.process_transfer(event, input, output, openhash)
      _ -> IO.puts("Oh ma ma my ... type error")
    end
  end
end
