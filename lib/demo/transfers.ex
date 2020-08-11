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
    erl_supul = Repo.preload(current_entity, :supul).supul
    ssu = Repo.one(from e in Entity, where: e.email == ^attrs["ssu_email"], select: e)
    ssu_supul = Repo.preload(ssu, :supul).supul

    attrs = Map.merge(%{
      "type" => "transfer", 
      "erl_email" => current_entity.email,
      "erl_supul_id" => erl_supul.id, 
      "ssu_supul_id" => ssu_supul.id}, 
      attrs)

    #? hard coded private keys
    {:ok, transfer} = %Transfer{} 
    |> Transfer.changeset(attrs)
    |> Repo.insert()

    erl_private_key = ExPublicKey.load!("./keys/hong_entity_private_key.pem")
    ssu_private_key = ExPublicKey.load!("./keys/tomi_private_key.pem")

    Events.create_event(transfer, erl_private_key, ssu_private_key)
    {:ok, transfer}
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
