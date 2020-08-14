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
    input = Repo.one(from u in User, where: u.email == ^attrs.bride_email, select: u)
    output = Repo.one(from u in User, where: u.email == ^attrs.groom_email, select: u)


    #? Stop if bride or groom is alread married.
    case input.married do
      true -> "error"
      false -> true
    end

    case output.married do
      true -> "error"
      false -> true
    end



    input_supul = Repo.preload(input, :supul).supul #? 이몽룡의 수풀
    input_supul_id = input_supul.id 
    input_supul_name = input_supul.name 

    output_supul = Repo.preload( output, :supul).supul #? 성춘향의 수풀
    output_supul_id = output_supul.id 
    output_supul_name = output_supul.name 

    
    attrs = Map.merge(attrs, %{
      input_id: input.id, 
      input_email: input.email,
      input_name: input.name, 
      input_supul_id: input_supul_id, 
      input_supul_name: input_supul_name, 

      output_id: output.id, 
      output_email: output.email,
      output_name: output.name,
      output_supul_id: output_supul_id,
      output_supul_name: output_supul_name,
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
