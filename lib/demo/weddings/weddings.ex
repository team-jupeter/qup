defmodule Demo.Weddings do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Weddings.Wedding
  # alias Demo.Supuls.Supul
  alias Demo.Accounts.User
  alias Demo.Events

  def list_weddings do
    Repo.all(Wedding)
  end


  def get_wedding!(id), do: Repo.get!(Wedding, id)

  def create_wedding(attrs \\ %{}) do
   %Wedding{}
    |> Wedding.changeset(attrs)
    |> Repo.insert()
  end

  def create_wedding(attrs \\ %{}, bride_private_key, groom_private_key) do
    bride = Repo.one(from u in User, where: u.email == ^attrs.bride_email, select: u)
    groom = Repo.one(from u in User, where: u.email == ^attrs.groom_email, select: u)

    erl_supul = Repo.preload(bride, :supul).supul
    erl_supul_id = erl_supul.id 

    ssu_supul = Repo.preload(groom, :supul).supul
    ssu_supul_id = ssu_supul.id 

    attrs = Map.merge(attrs, %{
      bride_id: bride.id, groom_id: groom.id, 
      erl_supul_id: erl_supul_id, ssu_supul_id: ssu_supul_id
    })

    IO.inspect attrs
    
    {:ok, wedding} = %Wedding{}
    |> Wedding.changeset(attrs)
    |> Repo.insert()

    Events.create_event(wedding, bride_private_key, groom_private_key)
  end


  def update_wedding(%Wedding{} = wedding, attrs) do
    IO.inspect "update_wedding"
    IO.inspect attrs
    
    wedding = Repo.preload(wedding, :openhash)
    wedding
    |> Wedding.changeset_openhash(attrs)
    |> Repo.update()
  end


  # def update_wedding(%Wedding{} = wedding, attrs) do
  #   wedding
  #   |> Wedding.changeset(attrs)
  #   |> Repo.update()
  # end


  def delete_wedding(%Wedding{} = wedding) do
    Repo.delete(wedding)
  end


  def change_wedding(%Wedding{} = wedding) do
    Wedding.changeset(wedding, %{})
  end
end
