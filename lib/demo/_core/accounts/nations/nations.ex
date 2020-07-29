defmodule Demo.Nations do

  import Ecto.Query, warn: false
  alias Demo.Repo

  alias Demo.Nations.Nation

  def list_nations do
    Repo.all(Nation)
  end


  def get_nation!(id), do: Repo.get!(Nation, id)

  def create_nation(attrs \\ %{}) do
    %Nation{}
    |> Nation.changeset(attrs)
    # |> Ecto.Changeset.put_assoc(:costitution, costitution)
    |> Repo.insert()
  end

  def update_nation(%Nation{} = nation, attrs) do
    nation
    |> Nation.changeset(attrs)
    |> Repo.update()
  end

  def update_nation_supul(%Nation{} = nation, attrs = %{nation_supul: nation_supul}) do
    nation = Repo.preload(nation, :nation_supul)
    nation
    |> Nation.changeset_supul(attrs)
    |> Repo.update()
  end

  def delete_nation(%Nation{} = nation) do
    Repo.delete(nation)
  end


  def change_nation(%Nation{} = nation) do
    Nation.changeset(nation, %{})
  end

  def authorize(nation, entity) do
    #? hard coded private key
    nation_priv_key = ExPublicKey.load!("./keys/korea_private_key.pem")

    #? auth code
    msg_serialized = Poison.encode!(entity)
    ts = DateTime.utc_now() |> DateTime.to_unix()
    ts_msg_serialized = "#{ts}|#{msg_serialized}"
    {:ok, signature} = ExPublicKey.sign(ts_msg_serialized, nation_priv_key)
    auth_code = :crypto.hash(:sha256, signature) |> Base.encode16() |> String.downcase()
  end    
end
