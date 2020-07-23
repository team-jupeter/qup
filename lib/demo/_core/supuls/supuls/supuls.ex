defmodule Demo.Supuls do
  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Supuls.Supul

  # alias Demo.Entities
  # alias Demo.Entities.Entity
  # alias Demo.StateSupuls
  # alias Demo.Openhashes.Openhash
  # alias Demo.NationSupuls.NationSupul
  # alias Demo.Openhashes.Openhash
  # alias Demo.Transactions

  def list_supuls do
    Repo.all(Supul)
  end 

  def get_supul!(id), do: Repo.get!(Supul, id)

  def create_supul(attrs) do
    Supul.changeset(attrs)
    |> Repo.insert() 
  end

  def update_supul(%Supul{} = supul, attrs) do
    supul
    |> Supul.changeset(attrs)
    |> Repo.update()
  end

  def update_hash_chain(%Supul{} = supul, attrs) do
    supul
    |> Supul.changeset_event_hash(attrs)
    |> Repo.update()
  end


  def delete_supul(%Supul{} = supul) do
    Repo.delete(supul)
  end


  def change_supul(%Supul{} = supul) do
    Supul.changeset(supul, %{})
  end


end
