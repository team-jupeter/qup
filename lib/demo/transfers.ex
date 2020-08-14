defmodule Demo.Transfers do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Transfers.Transfer
  alias Demo.Events.Event
  alias Demo.Events
  alias Demo.Entities.Entity

  def list_transfers do
    Repo.all(Transfer)
  end


  def get_transfer!(id), do: Repo.get!(Transfer, id)


  def create_transfer(attrs \\ %{}, current_entity) do
    input = current_entity
    output = Repo.one(from e in Entity, where: e.email == ^attrs["output_email"], select: e)
    
    input_gab = Repo.preload(input, :gab).gab
    output_gab = Repo.preload(output, :gab).gab

    input_supul = Repo.preload(input, :supul).supul
    output_supul = Repo.preload(output, :supul).supul

    input_state_supul = Repo.preload(input_supul, :state_supul).state_supul
    output_state_supul = Repo.preload(output_supul, :state_supul).state_supul

    input_nation_supul = Repo.preload(input_state_supul, :nation_supul).nation_supul
    output_nation_supul = Repo.preload(output_state_supul, :nation_supul).nation_supul

    input_currency = input.default_currency
    output_currency = output.default_currency
    
    output_amount = fx(input_currency, output_currency, attrs["input_amount"])
    

    attrs = Map.merge(%{
      "type" => "transfer", 
      "input_email" => current_entity.email,
      "input_gab_id" => input_gab.id, 
      "output_gab_id" => output_gab.id,
      "input_supul_id" => input_supul.id, 
      "output_supul_id" => output_supul.id,
      "input_state_supul_id" => input_state_supul.id, 
      "output_state_supul_id" => output_state_supul.id,
      "input_nation_supul_id" => input_nation_supul.id, 
      "output_nation_supul_id" => output_nation_supul.id,

      "input_currency" => input.default_currency,

      "output_currency" => output.default_currency,
      "output_amount" => output_amount,
      }, 
      attrs)

      IO.inspect "attrs"
      IO.inspect attrs

    #? hard coded private keys
    {:ok, transfer} = %Transfer{} 
    |> Transfer.changeset(attrs)
    |> Repo.insert()

    input_private_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    output_private_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    Events.create_event(transfer, input_private_key, output_private_key)
    {:ok, transfer} 
  end

  defp fx(input_currency, output_currency, input_amount) do
    #? return dummy value
    input_amount
  end
  
  def update_transfer(%Transfer{} = transfer, attrs) do
    transfer
    |> Transfer.changeset(attrs)
    |> Repo.update()
  end


  def delete_transfer(%Transfer{} = transfer) do
    Repo.delete(transfer)
  end


  def change_transfer(%Transfer{} = transfer) do
    Transfer.changeset(transfer, %{})
  end
end
