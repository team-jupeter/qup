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

  def create_wedding(attrs) do
    erl = Repo.one(from u in User, where: u.email == ^attrs.bride_email, select: u)
    ssu = Repo.one(from u in User, where: u.email == ^attrs.groom_email, select: u)


    #? Stop if bride or groom is alread married.
    case erl.married do
      true -> "error"
      false -> true
    end

    case ssu.married do
      true -> "error"
      false -> true
    end



    erl_supul = Repo.preload(erl, :supul).supul #? 이몽룡의 수풀
    erl_supul_id = erl_supul.id 
    erl_supul_name = erl_supul.name 

    ssu_supul = Repo.preload(ssu, :supul).supul #? 성춘향의 수풀
    ssu_supul_id = ssu_supul.id 
    ssu_supul_name = ssu_supul.name 

    
    attrs = Map.merge(attrs, %{
      erl_id: erl.id, 
      erl_email: erl.email,
      erl_name: erl.name, 
      erl_supul_id: erl_supul_id, 
      erl_supul_name: erl_supul_name, 

      ssu_id: ssu.id, 
      ssu_email: ssu.email,
      ssu_name: ssu.name,
      ssu_supul_id: ssu_supul_id,
      ssu_supul_name: ssu_supul_name,
    })
     
    %Wedding{}
    |> Wedding.changeset(attrs)
    |> Repo.insert()
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
