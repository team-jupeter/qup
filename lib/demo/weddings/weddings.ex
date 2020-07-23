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

    erl_supul = Repo.preload(bride, :supul).supul #? 이몽룡의 수풀
    erl_supul_id = erl_supul.id 
    erl_supul_name = erl_supul.name 

    ssu_supul = Repo.preload(groom, :supul).supul #? 성춘향의 수풀
    ssu_supul_id = ssu_supul.id 
    ssu_supul_name = ssu_supul.name 

    
    attrs = Map.merge(attrs, %{
      bride_id: bride.id, 
      groom_id: groom.id, 
      bride_name: bride.name, 
      groom_name: groom.name,

      erl_supul_id: erl_supul_id, 
      erl_supul_name: erl_supul_name, 
      ssu_supul_id: ssu_supul_id,
      ssu_supul_name: ssu_supul_name,

      erl_email: attrs.bride_email,
      ssu_email: attrs.groom_email
    })
     
    {:ok, wedding} = %Wedding{}
    |> Wedding.changeset(attrs)
    |> Repo.insert() #? 결혼 신고서 

    Events.create_event(wedding, bride_private_key, groom_private_key)
  end

  def add_openhash(wedding, attrs) do
    IO.puts "add_openhash"
    Repo.preload(wedding, :openhashes) |> Wedding.changeset_openhash(attrs) |> Repo.update() 
  end

  def update_wedding(%Wedding{} = wedding, attrs) do 
    wedding
    |> Wedding.changeset(attrs)
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
