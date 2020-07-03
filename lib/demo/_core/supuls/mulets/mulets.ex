defmodule Demo.Mulets do
  @moduledoc """
  The Mulets context.
  """

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Mulets.Mulet
  alias Demo.Mulets.PayloadArchive
  alias Demo.Mulets.Payload
  alias Demo.Mulets.Openhash

  def list_mulets do
    Repo.all(Mulet)
  end

  def get_mulet!(id), do: Repo.get!(Mulet, id)
    

  def create_mulet(attrs \\ %{}) do
    %Mulet{}
    |> Mulet.changeset(attrs)
    |> Repo.insert()
  end

  # Mulets.create_payload(%{data: payload}) 
  def create_payload_archive(attrs) do
    %PayloadArchive{}
    |> PayloadArchive.changeset(attrs)
    |> Repo.insert()
  end 

  def openhash(params) do
    IO.puts "I am here Mulets.openhash"
    IO.inspect params

    
    %Openhash{}
    |> Openhash.changeset(params)
    |> Repo.insert()
    |> IO.inspect
    |> put_openhash()
    |> Repo.update()
    |> IO.inspect
  end
  
  defp put_openhash({:ok, openhash}) do
    IO.puts "I am here Mulets.put_openhash"
    combined_hash = openhash.payload_hash <> openhash.chained_hash 
    chained_hash = Pbkdf2.hash_pwd_salt(combined_hash)

    Openhash.changeset(openhash, %{chained_hash: chained_hash})
  end


  def update_mulet(%Mulet{} = mulet, attrs) do
    mulet
    |> Mulet.changeset(attrs)
    |> Repo.update()
  end


  def delete_mulet(%Mulet{} = mulet) do
    Repo.delete(mulet)
  end


  def change_mulet(%Mulet{} = mulet) do
    Mulet.changeset(mulet, %{})
  end
end
